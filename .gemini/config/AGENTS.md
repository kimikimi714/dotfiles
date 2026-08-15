# Global Agent Rules & Policies

This file defines the global guidelines, allowed workflows, and restricted operations for Antigravity agents across all workspaces.

## Command Execution Policies

### Denied Operations (Restricted)
- **Destructive File Operations**: Do not run destructive commands directly (e.g., `rm -rf`, `rm` on untracked/unverified files, `git clean -fdx`, or script one-liners like `node -e 'fs.unlinkSync(...)'`). Request explicit user confirmation or let the user handle deletion.
- **Force Pushes / Destructive Git**: Never execute `git push --force` or commands that rewrite shared remote history without explicit user instruction.
- **Direct System Modification**: Do not modify system-level packages or sudoers directly unless specifically instructed.

### Allowed & Recommended Workflows
- **Package Management**: Use Homebrew (`Brewfile`) or `mise` for managing runtimes and CLI tools.
- **Safe Dotfiles Updates**: Ensure existing files are safely backed up before overwriting or relinking configurations.
- **Git Branch & File Operations**: Always use `git switch` / `git switch -c` for branches, and `git restore` for files (avoid legacy `git checkout`).

## Git Commit Guidelines (Context-Preserving Commits)

To ensure that AI agents and collaborators can maintain and reconstruct context from repository history, all Git commits MUST adhere to the following rules:

### 1. Structure
```text
[<emoji_code>] <Summary (What)>

[Why / Context]
Detailed explanation of why this change was needed, background, and motivation.

[Details] (Optional)
- Specific changes made
- Impact on other components or workflows
```

### 2. Core Requirements
- **Never create 1-line commits**: A 1-line commit loses critical context for future AI agents and team members.
- **Always explain Why**: Prioritize explaining the background, motivation, and reasons behind the decision, not just the raw code diff (What).
- **Header Emojis (Optional / Recommended)**: Emojis defined in `emoji.md` can optionally be used as prefixes (e.g., `:+1:`, `:new:`, `:bug:`), but providing rich context in the body is the primary requirement.
