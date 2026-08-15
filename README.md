dotfiles
====

Settings for Ubuntu / WSL.

## Setup

```bash
# Run setup script
./setup.sh
```

### Features

- **Safe Backup**: If existing config files (e.g. `~/.bashrc`, `~/.profile`) already exist, they are automatically backed up to `~/.dotfiles_backup/YYYYMMDD_HHMMSS/` before creating symlinks.
- **Symlinking**: Links dotfiles directly to `$HOME`.
- **Vim-Plug**: Automatically installs `vim-plug` if missing.
- **Brew Bundle**: Prompts to run `brew bundle` to install all packages in `Brewfile` (including `mise`).
