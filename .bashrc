# 特定ディレクトリへのalias
alias GC="cd ${DOCUMENTS_DIR}/git_clone"
alias GR="cd ${DOCUMENTS_DIR}/git_repo"

# 実行時オプションとかショートカットaliasの設定
alias ls='ls -G'

# rbenvの設定
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# phpenvの設定
export PATH="$HOME/.phpenv/bin:$PATH"
eval "$(phpenv init -)"

# gitコマンドラインの見せ方設定
source ${DOCUMENTS_DIR}/git_repo/config/git-prompt.sh
source ${DOCUMENTS_DIR}/git_repo/config/git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '

# homebrewでインストールしたものが/usr/binより先に読み込まれるようにするための設定
export PATH="/usr/local/bin:$PATH"
