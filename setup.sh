#!/usr/bin/env bash
set -euo pipefail

# -----------------------------------------------------------------------------
# dotfiles setup script
# -----------------------------------------------------------------------------

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +'%Y%m%d_%H%M%S')"
BACKUP_CREATED=false

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

echo "========================================"
echo " Starting dotfiles setup"
echo " Dotfiles directory: $DOTFILES_DIR"
echo "========================================"

# Target files to link: "source_relative_path:target_absolute_path"
FILES_TO_LINK=(
    ".bashrc:$HOME/.bashrc"
    ".profile:$HOME/.profile"
    ".gitconfig:$HOME/.gitconfig"
    ".vimrc:$HOME/.vimrc"
    "gitignoreGlobal:$HOME/.gitignore_global"
    ".gemini/config:$HOME/.gemini/config"
)

# 1. Create Symlinks with backup
info "Creating symlinks..."

for entry in "${FILES_TO_LINK[@]}"; do
    src_rel="${entry%%:*}"
    dest="${entry#*:}"
    src="$DOTFILES_DIR/$src_rel"

    if [ ! -e "$src" ]; then
        warn "Source file not found: $src (skipping)"
        continue
    fi

    # Check if destination exists and is already the correct symlink
    if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
        success "Already linked: $dest -> $src"
        continue
    fi

    # If destination exists (file, directory, or different symlink), back it up
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        if [ "$BACKUP_CREATED" = false ]; then
            mkdir -p "$BACKUP_DIR"
            BACKUP_CREATED=true
            info "Backup directory created at: $BACKUP_DIR"
        fi
        mv "$dest" "$BACKUP_DIR/"
        warn "Existing file backed up: $dest -> $BACKUP_DIR/$(basename "$dest")"
    fi

    # Create destination directory if parent doesn't exist
    mkdir -p "$(dirname "$dest")"

    # Create symbolic link
    ln -sfn "$src" "$dest"
    success "Linked: $dest -> $src"
done

# 2. vim-plug setup (if vim is used and vim-plug is not installed)
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
    info "Installing vim-plug..."
    if command -v curl >/dev/null 2>&1; then
        curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        success "vim-plug installed."
    else
        warn "curl not found. Skipped vim-plug installation."
    fi
fi

# 3. Brewfile bundle (optional check)
if command -v brew >/dev/null 2>&1 && [ -f "$DOTFILES_DIR/Brewfile" ]; then
    read -rp "Run 'brew bundle' now? (y/N): " answer
    if [[ "$answer" =~ ^[Yy]$ ]]; then
        info "Running brew bundle..."
        brew bundle --file="$DOTFILES_DIR/Brewfile"
        success "Brew packages installed."
    else
        info "Skipped 'brew bundle'. You can run it manually anytime."
    fi
fi

echo "========================================"
if [ "$BACKUP_CREATED" = true ]; then
    echo -e "${YELLOW}Existing files were backed up to:${NC}"
    echo "  $BACKUP_DIR"
    echo "========================================"
fi
success "Dotfiles setup completed!"
info "Please run: source ~/.bashrc (or restart your terminal)"
