# ドキュメントディレクトリを示す環境変数設定
export DOCUMENTS="$HOME/Documents"

# coreutilsの設定
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

# rbenvの設定
export PATH="$HOME/.rbenv/shims:$PATH"
eval "$(rbenv init - zsh)"

# php56の設定
export PATH="$(brew --prefix homebrew/php/php56)/bin:$PATH"

# pythonのパス設定
export PYTHONENV="$(brew --prefix)/lib/python2.7/site-packages"
