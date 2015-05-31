# 特定ディレクトリへのalias
alias GC="cd ${DOCUMENTS_DIR}/git_clone"
alias GR="cd ${DOCUMENTS_DIR}/git_repo"
alias V="cd ${DOCUMENTS_DIR}/vagrant"

# 実行時オプションとかショートカットaliasの設定
alias ls='ls -G'
alias grep='grep --color'
alias pass='mono ~/Downloads/KeePass-2.26/KeePass.exe'

# rbenvの設定
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# gitコマンドラインの見せ方設定
source $(brew --prefix)/etc/bash_completion.d/git-prompt.sh
source $(brew --prefix)/etc/bash_completion.d/git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '

# homebrewでインストールしたものが/usr/binより先に読み込まれるようにするための設定
export PATH="/usr/local/bin:$PATH"

# playのPATH追加(2015-05-31)
export PATH="$HOME/Downloads/activator-1.3.2-minimal:$PATH"
