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

## Antigravity Pre-tool Hooks (Safety Guard & Command Rewriter)

Antigravity の `PreToolUse` Hook を活用し、以下の2つの保護・置換機能をグローバルに提供しています：

1. **破壊的ファイル削除の徹底遮断（Security Guard）**:
   - 直接の `rm`, `unlink`, `trash`, `git clean`, `git rm`, `find -delete` などはもちろん、
   - **Node.js (`fs.unlinkSync`, `fs.rmSync`)、Python (`os.remove`, `shutil.rmtree`)、Ruby 等のワンライナースクリプトによる迂回削除も検知して即座にハードブロック（`deny`）** します。
   - 遮断時はエージェントにポリシー違反警告を通知し、作業を強制停止させます。

2. **`git checkout` の自動置換**:
   - レガシーな `git checkout` コマンドを、安全かつ推奨される **`git switch`**（ブランチ操作）または **`git restore`**（ファイル変更復元）に自動書き換えします。

### 有効化設定 (`.gemini/config/hooks.json`)

```json
{
  "safety-and-rewrite-guard": {
    "PreToolUse": [
      {
        "matcher": "run_command",
        "hooks": [
          {
            "type": "command",
            "command": "python3 ./scripts/pre-tool-guard.py"
          }
        ]
      }
    ]
  }
}
```
