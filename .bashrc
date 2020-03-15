# gitコマンドラインの見せ方設定
source /etc/profile.d/bash_completion.sh
source /usr/share/bash-completion/completions/git
GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '
