# ドキュメントディレクトリを示す環境変数設定
export DOCUMENTS="$HOME/Documents"

# coreutilsの設定
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

# rbenvの設定
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"

# scala path
export PATH="$HOME/Downloads/scala-2.11.6/bin:$PATH"

# playのPATH追加(2015-05-31)
export PATH="$HOME/Downloads/activator-1.3.2-minimal:$PATH"

# php56の設定
export PATH="$(brew --prefix homebrew/php/php56)/bin:$PATH"

# pythonのパス設定
export PYTHONENV="$(brew --prefix)/lib/python2.7/site-packages"
