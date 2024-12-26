# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# set neovim as a default text editor
export EDITOR="nvim"
export VISUAL="nvim"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
# export HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=1000
export HISTFILESIZE=2000
export HISTCONTROL=ignoredups:ignorespace:erasedups


# append to the history file, don't overwrite it
# shopt -s histappend

# This command appends the current session's history to the .bash_history file
# each time when a new command is executed within bash.
# PROMPT_COMMAND="history -w;$PROMPT_COMMAND"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar


# make less more friendly for non-text input files, see lesspipe(1)
# for example it make less to be able to read PDF's, archives and so on
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


alias venv-poetry='.venv-poetry/bin/poetry'
alias p='python'
alias p3='python3'
alias d='deactivate'
alias s='source'
alias c='clear'
alias fk='history -d -2'  # drop last command from bash history
alias b='bat --color=always'
alias zj='zellij'
alias lg='lazygit'
alias lzd='lazydocker'
alias nv='nvim'
alias tm='tmux'
function cd {
    # Use the built-in cd command to change directories
    # and return immediately if any error happened
    builtin cd "$@" || return
    # Execute ls in the new directory
    ls
}
function lgp {
    lg -p "$1"
}


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# pyenv configuration
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


# nvm configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# add neovim
export PATH="$PATH:$HOME/programs/nvim-linux64/bin"

# add zellij
export PATH="$PATH:$HOME/programs/zellij"

# add zoxide
export PATH="$PATH:$HOME/programs/zoxide"
# set up zoxide autocompletions
eval "$(zoxide init bash)"

# add lazygit
export PATH="$PATH:$HOME/programs/lazygit"

# add lazydocker
export PATH="$PATH:$HOME/programs/lazydocker"

# add bat
export PATH="$PATH:$HOME/programs/bat"

# add tmux
export PATH="$PATH:$HOME/programs/tmux/bin"

# add ripgrep
export PATH="$PATH:$HOME/programs/ripgrep"

# add fzf
export PATH="$PATH:$HOME/programs/fzf"
# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"
# enable fzf completion for "nv" alias
_fzf_setup_completion path nv
export FZF_CTRL_T_OPTS="--preview='bat --color=always {}'"


# # ex = EXtractor for all kinds of archives
# # usage: ex <file>
ex ()
{
if [ -f $1 ] ; then
    case $1 in
	*.tar.bz2)   tar xjf $1   ;;
	*.tar.gz)    tar xzf $1   ;;
	*.bz2)       bunzip2 $1   ;;
	*.rar)       unrar x $1   ;;
	*.gz)        gunzip $1    ;;
	*.tar)       tar xf $1    ;;
	*.tbz2)      tar xjf $1   ;;
	*.tgz)       tar xzf $1   ;;
	*.zip)       unzip $1     ;;
	*.Z)         uncompress $1;;
	*.7z)        7z x $1      ;;
	*.deb)       ar x $1      ;;
	*.tar.xz)    tar xf $1    ;;
	*.tar.zst)   tar xf $1    ;;
	*)           echo "'$1' cannot be extracted via ex()" ;;
    esac
else
    echo "'$1' is not a valid file"
fi
}

. "$HOME/.cargo/env"
