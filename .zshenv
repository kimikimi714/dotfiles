# ドキュメントディレクトリを示す環境変数設定
export DOCUMENTS="$HOME/Documents"
export MOUNT_DISK="/Volumes/HDPC-UT/mac_backup"

# coreutilsの設定
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

# rbenvの設定
export PATH="$HOME/.rbenv/shims:$PATH"
eval "$(rbenv init - zsh)"

# php56の設定
export PATH="$(brew --prefix homebrew/php/php56)/bin:$PATH"

# pythonのパス設定
export PYTHONENV="$(brew --prefix)/lib/python2.7/site-packages"

export VAULT_ADDR='http://127.0.0.1:8200'
