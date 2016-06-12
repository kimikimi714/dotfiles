# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
  fi
# homebrewでインストールしたものが/usr/binより先に読み込まれるようにするための設定
export PATH="/usr/local/bin:$PATH"

# http://qiita.com/t-takaai/items/8574ff312f2caa5177c2
setopt no_global_rcs

# ドキュメントディレクトリを示す環境変数設定
export DOCUMENTS="$HOME/Documents"

# coreutilsの設定
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

# pythonのパス設定
export PYTHONENV="$(brew --prefix)/lib/python2.7/site-packages"

export VAULT_ADDR='http://127.0.0.1:8200'

