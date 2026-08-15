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
- **Mise (Runtime Management)**: Manages Python and Node.js versions via `mise.toml`.

---

## Python Setup (mise)

このリポジトリでは Python 実行環境を `mise` で管理しています（Pre-tool Hook スクリプト等の実行に使用）。

```bash
# mise.toml に定義されたツール（Python 等）をインストール
mise install
```

---

## Antigravity Pre-tool Hooks (git checkout -> git switch / restore)

Antigravity エージェントが実行するレガシーな `git checkout` コマンドを、安全かつ推奨される **`git switch`**（ブランチ操作）または **`git restore`**（ファイル変更復元）に自動置換する Pre-tool Hook を導入しています。

### 有効化に必要な設定

1. **Python 環境の準備 (`mise.toml`)**:
   Hook スクリプトの実行に Python 3 が必要です。リポジトリルートの `mise.toml` に以下を記述します：
   ```toml
   [tools]
   python = "3.12"
   ```

2. **Hook の登録 (`.gemini/config/hooks.json`)**:
   `run_command` 実行直前にスクリプトを呼び出す設定を行います：
   ```json
   {
     "git-checkout-rewriter": {
       "PreToolUse": [
         {
           "matcher": "run_command",
           "hooks": [
             {
               "type": "command",
               "command": "./scripts/git-checkout-rewrite.py"
             }
           ]
         }
       ]
     }
   }
   ```

3. **置換スクリプト (`.gemini/config/scripts/git-checkout-rewrite.py`)**:
   - `git checkout -b <branch>` → `git switch -c <branch>`
   - `git checkout <branch>` → `git switch <branch>`
   - `git checkout -- <file>` / `git checkout <file>` → `git restore <file>`
   - `git checkout <commit> <file>` → `git restore --source=<commit> <file>`
   - `git checkout .` → `git restore .`
