#!/usr/bin/env python3
import json
import subprocess
import os

cases = [
    ("git checkout -b feature/awesome", "git switch -c feature/awesome"),
    ("git checkout -B hotfix/urgent", "git switch -C hotfix/urgent"),
    ("git checkout ubuntu", "git switch ubuntu"),
    ("git checkout -", "git switch -"),
    ("git checkout -- README.md", "git restore README.md"),
    ("git checkout .", "git restore ."),
    ("git checkout HEAD -- README.md", "git restore --source=HEAD README.md"),
    ("git checkout -p", "git restore -p"),
    ("git checkout --ours file.txt", "git restore --ours file.txt"),
    ("git checkout --track origin/feature", "git switch --track origin/feature"),
    ("git status && git checkout -b my-branch", "git status && git switch -c my-branch"),
]

script_path = os.path.expanduser("/home/kimikimi714/src/github.com/kimikimi714/dotfiles/.gemini/config/scripts/git-checkout-rewrite.py")
cwd = "/home/kimikimi714/src/github.com/kimikimi714/dotfiles"

for cmd, expected in cases:
    payload = json.dumps({"toolCall": {"name": "run_command", "args": {"CommandLine": cmd, "Cwd": cwd}}})
    p = subprocess.run(["python3", script_path], input=payload, text=True, capture_output=True)
    res = json.loads(p.stdout)
    actual = res.get("overwrite", {}).get("CommandLine", "")
    decision = res.get("decision", "")
    assert decision == "allow", f"Expected decision allow, got {decision}"
    assert actual == expected, f"Failed for '{cmd}': expected '{expected}', got '{actual}'"
    print(f"✔ {cmd:45} -> {actual}")

print("\nAll 11 test cases passed successfully!")
