# ドキュメントディレクトリを示す環境変数設定
export DOCUMENTS_DIR="${HOME}/Documents"
# coreutilsの設定
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
# rbenvの設定
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"

