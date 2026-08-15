#!/usr/bin/env python3
"""
PreToolUse Hook Script for Antigravity:
Rewrites legacy `git checkout` commands into modern and safe `git switch` or `git restore` commands.
"""

import json
import os
import re
import shlex
import subprocess
import sys


def is_branch_or_commit(cwd: str, ref: str) -> bool:
    """Check if the ref is a valid git revision (branch, tag, commit)."""
    if not ref or ref.startswith("-"):
        return False
    try:
        res = subprocess.run(
            ["git", "rev-parse", "--verify", f"{ref}^{{commit}}"],
            cwd=cwd,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        if res.returncode == 0:
            return True
        res_remote = subprocess.run(
            ["git", "show-ref", "--verify", f"refs/remotes/origin/{ref}"],
            cwd=cwd,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        return res_remote.returncode == 0
    except Exception:
        return False


def is_file_or_dir(cwd: str, path: str) -> bool:
    """Check if the path exists in working tree or git index."""
    if not path or path.startswith("-"):
        return False
    full_path = os.path.join(cwd, path) if not os.path.isabs(path) else path
    if os.path.exists(full_path):
        return True
    try:
        res = subprocess.run(
            ["git", "ls-files", "--error-unmatch", path],
            cwd=cwd,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        return res.returncode == 0
    except Exception:
        return False


def rewrite_single_command(cwd: str, cmd_str: str) -> str:
    """Parse and rewrite a single git checkout command string."""
    try:
        tokens = shlex.split(cmd_str)
    except ValueError:
        return cmd_str

    if len(tokens) < 2 or tokens[0] != "git" or tokens[1] != "checkout":
        return cmd_str

    args = tokens[2:]
    if not args:
        return cmd_str

    # 1. Explicit separator `--`
    if "--" in args:
        dash_idx = args.index("--")
        before_dash = args[:dash_idx]
        after_dash = args[dash_idx + 1 :]

        if not before_dash:
            return shlex.join(["git", "restore"] + after_dash)
        elif len(before_dash) == 1 and not before_dash[0].startswith("-"):
            tree_ish = before_dash[0]
            return shlex.join(["git", "restore", f"--source={tree_ish}"] + after_dash)
        elif "-p" in before_dash or "--patch" in before_dash:
            clean_before = [x for x in before_dash if x not in ("-p", "--patch")]
            res = ["git", "restore", "--patch"]
            if clean_before:
                res.append(f"--source={clean_before[0]}")
            return shlex.join(res + after_dash)

    # 2. Branch creation & switching flags
    if "-b" in args:
        new_args = ["-c" if x == "-b" else x for x in args]
        return shlex.join(["git", "switch"] + new_args)

    if "-B" in args:
        new_args = ["-C" if x == "-B" else x for x in args]
        return shlex.join(["git", "switch"] + new_args)

    if any(opt in args for opt in ("--orphan", "--detach", "--track", "-t")):
        return shlex.join(["git", "switch"] + args)

    # 3. File restoration flags
    if any(opt in args for opt in ("--ours", "--theirs", "-p", "--patch", "--conflict")):
        return shlex.join(["git", "restore"] + args)

    # 4. Special shorthand targets
    if args == ["-"]:
        return "git switch -"

    if args == ["."]:
        return "git restore ."

    # 5. Single argument disambiguation (e.g. `git checkout <target>`)
    if len(args) == 1 and not args[0].startswith("-"):
        target = args[0]
        has_file = is_file_or_dir(cwd, target)
        has_ref = is_branch_or_commit(cwd, target)

        if has_file and not has_ref:
            return shlex.join(["git", "restore", target])
        elif has_ref and not has_file:
            return shlex.join(["git", "switch", target])
        elif has_file and has_ref:
            return shlex.join(["git", "switch", target])
        else:
            if ("/" in target and not target.startswith("origin/")) or (
                "." in os.path.basename(target) and not target.startswith("v")
            ):
                return shlex.join(["git", "restore", target])
            return shlex.join(["git", "switch", target])

    # 6. Two arguments: `git checkout <tree-ish> <path>`
    if len(args) == 2 and not args[0].startswith("-") and not args[1].startswith("-"):
        tree_ish, path = args[0], args[1]
        if is_branch_or_commit(cwd, tree_ish) and (is_file_or_dir(cwd, path) or "." in path):
            return shlex.join(["git", "restore", f"--source={tree_ish}", path])

    # 7. Force flag with target
    if "-f" in args or "--force" in args:
        non_flags = [x for x in args if not x.startswith("-")]
        if non_flags:
            if is_file_or_dir(cwd, non_flags[0]) and not is_branch_or_commit(cwd, non_flags[0]):
                return shlex.join(["git", "restore"] + args)
            else:
                return shlex.join(["git", "switch"] + args)

    return cmd_str


def rewrite_command_line(cwd: str, command_line: str) -> str:
    """Split composite command lines by operators (&&, ||, ;, |) and rewrite each git checkout."""
    tokens = re.split(r'(\s*(?:&&|\|\||;|\|)\s*)', command_line)
    rewritten_tokens = []

    for token in tokens:
        if re.match(r'^\s*(?:&&|\|\||;|\|)\s*$', token):
            rewritten_tokens.append(token)
        else:
            stripped = token.strip()
            if stripped.startswith("git checkout"):
                rewritten_sub = rewrite_single_command(cwd, stripped)
                rewritten_tokens.append(token.replace(stripped, rewritten_sub, 1))
            else:
                rewritten_tokens.append(token)

    return "".join(rewritten_tokens)


def main():
    try:
        raw_input = sys.stdin.read()
        if not raw_input.strip():
            print(json.dumps({"decision": "allow"}))
            return
        input_data = json.loads(raw_input)
    except Exception:
        print(json.dumps({"decision": "allow"}))
        return

    tool_call = input_data.get("toolCall", {})
    tool_name = tool_call.get("name")

    if tool_name != "run_command":
        print(json.dumps({"decision": "allow"}))
        return

    args = tool_call.get("args", {})
    command_line = args.get("CommandLine", "")
    cwd = args.get("Cwd") or os.getcwd()

    if "git checkout" not in command_line:
        print(json.dumps({"decision": "allow"}))
        return

    rewritten_cmd = rewrite_command_line(cwd, command_line)

    if rewritten_cmd != command_line:
        response = {
            "decision": "allow",
            "overwrite": {
                "CommandLine": rewritten_cmd
            }
        }
        print(json.dumps(response))
    else:
        print(json.dumps({"decision": "allow"}))


if __name__ == "__main__":
    main()
