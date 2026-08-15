# ~/.bashrc: executed by bash(1) for non-login interactive shells.

# 1. Non-interactive shell guard
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# 2. Linuxbrew (ensure brew is available in non-login interactive shells)
if [ -d "/home/linuxbrew/.linuxbrew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
fi

# 3. History settings
# - don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
# - append to the history file, don't overwrite it
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=20000

# 4. Terminal & Shell options
# - check the window size after each command and update LINES and COLUMNS
shopt -s checkwinsize
# - make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# 5. Colors & Aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
else
    alias ls='ls --color=auto'
fi
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'

# 6. Programmable Completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  elif [ -f /etc/profile.d/bash_completion.sh ]; then
    . /etc/profile.d/bash_completion.sh
  fi
fi

# 7. Git Prompt & Prompt Configuration (PS1)
# Load git prompt helper if available
if [ -f /usr/lib/git-core/git-sh-prompt ]; then
    . /usr/lib/git-core/git-sh-prompt
elif [ -f /usr/share/bash-completion/completions/git ]; then
    . /usr/share/bash-completion/completions/git
fi

# Set debian_chroot if in chroot
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

GIT_PS1_SHOWDIRTYSTATE=true
export PS1='${debian_chroot:+($debian_chroot)}\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '

# 8. Interactive Tools & Functions
# mise (runtime version manager)
if command -v mise >/dev/null 2>&1; then
    eval "$(mise activate bash)"
fi

# fzf key bindings / completion (if fzf supports shell integration)
if command -v fzf >/dev/null 2>&1; then
    eval "$(fzf --bash 2>/dev/null)" || true
fi

# ghq + fzf repository jump
function repo {
    if ! command -v ghq >/dev/null 2>&1 || ! command -v fzf >/dev/null 2>&1; then
        echo "repo: ghq or fzf is not installed." >&2
        return 1
    fi
    local dir
    dir="$(ghq list -p | fzf)"
    if [ -n "$dir" ]; then
        cd "$dir" || return
    fi
}

# fzf history search
function hist-grep {
    if ! command -v fzf >/dev/null 2>&1; then
        echo "hist-grep: fzf is not installed." >&2
        return 1
    fi
    local cmd
    cmd="$(history | fzf)"
    echo "$cmd"
}

