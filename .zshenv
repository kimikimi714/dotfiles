# ドキュメントディレクトリを示す環境変数設定
export DOCUMENTS="$HOME/Documents"
export MOUNT_DISK="/Volumes/HDPC-UT/mac_backup"

# coreutilsの設定
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

# rbenvの設定
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"

# scala path
export PATH="$HOME/Downloads/scala-2.11.6/bin:$PATH"

# playのPATH追加(2015-05-31)
export PATH="$HOME/Downloads/activator-1.3.2-minimal:$PATH"
