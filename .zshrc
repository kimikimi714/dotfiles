# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# powerline10k theme https://github.com/romkatv/powerlevel10k
source $HOME/go/src/github.com/romkatv/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# 入力したコマンドが存在せず、かつディレクトリ名と一致するなら、そのディレクトリに移動
setopt auto_cd

# cdした先のディレクトリをディレクトリスタックに追加する
setopt auto_pushd

# pushdしたときに、ディレクトリが既にスタックに含まれていればスタックに追加しない
setopt pushd_ignore_dups

# 入力したコマンドが既にコマンド履歴に含まれる場合、履歴が古い方のコマンドを削除する
setopt hist_ignore_all_dups

# コマンドがスペースで始まる場合、コマンド履歴に追加しない
# 例： <Space>echo hello と入力
setopt hist_ignore_space

# homebrewでインストールしたものが/usr/binより先に読み込まれるようにするための設定
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# home bin
export PATH=${HOME}/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"

function repo {
  local dir="$( ghq list -p | fzf )"
  if [ ! -z "$dir" ] ; then
    cd "$dir"
  fi
}

function docker {
  case $1 in
    ps)
      shift
      command dops "$@"
      ;;
    *)
      command docker "$@";;
  esac
}

# 実行時オプションとかショートカットaliasの設定
alias ls='ls -G'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/kimikimi714/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/kimikimi714/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/kimikimi714/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/kimikimi714/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
# explicitly point to Python interpreter for gcloud command
# see: https://cloud.google.com/sdk/gcloud/reference/topic/startup
export CLOUDSDK_PYTHON=python3
# explicitly point to Python 2 interpreter for dev_appserver.py
# see: https://cloud.google.com/appengine/docs/standard/tools/using-local-server?tab=python#set-up
export CLOUDSDK_DEVAPPSERVER_PYTHON=python2

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# GitHub CLI completion
eval "$(gh completion -s zsh)"

# pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# less のオプション
export LESS='-i -M -R'
export MORE='-i -M -R'
# man を色付きでみるために default pager を less にする
export PAGER=less
export LESS_TERMCAP_mb=$'\E[01;31m'      # Begins blinking.
export LESS_TERMCAP_md=$'\E[01;31m'      # Begins bold.
export LESS_TERMCAP_me=$'\E[0m'          # Ends mode.
export LESS_TERMCAP_se=$'\E[0m'          # Ends standout-mode.
export LESS_TERMCAP_so=$'\E[00;47;30m'   # Begins standout-mode.
export LESS_TERMCAP_ue=$'\E[0m'          # Ends underline.
export LESS_TERMCAP_us=$'\E[01;32m'      # Begins underline.

# setup GOPATH
export PATH="${HOME}/go/bin":$PATH

# Load rbenv automatically by appending
# the following to ~/.zshrc:
eval "$(rbenv init - zsh)"
export PATH="${HOME}/.rbenv/shims":$PATH

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

