# Global Agent Rules & Policies

This file defines the global guidelines, allowed workflows, and restricted operations for Antigravity agents across all workspaces.

## Command Execution Policies

### Denied Operations (Restricted)
- **Destructive File Operations**: Do not run destructive commands directly (e.g., `rm -rf`, `rm` on untracked/unverified files, `git clean -fdx`). Request explicit user confirmation or let the user handle deletion.
- **Force Pushes / Destructive Git**: Never execute `git push --force` or commands that rewrite shared remote history without explicit user instruction.
- **Direct System Modification**: Do not modify system-level packages or sudoers directly unless specifically instructed.

### Allowed & Recommended Workflows
- **Package Management**: Use Homebrew (`Brewfile`) or `mise` for managing runtimes and CLI tools.
- **Git Commits**: Follow repository commit conventions (e.g., emoji prefix defined in `emoji.md`) and keep commits atomic.
- **Safe Dotfiles Updates**: Ensure existing files are safely backed up before overwriting or relinking configurations.
