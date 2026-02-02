#!/usr/bin/bash


if [[ "$BASHPROFILE_LOADED" != "true" ]]; then
    . "$HOME/.bash_profile"
    return
fi


# set neovim as a default text editor
export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER="nvim +Man!"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
# export HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=2000
export HISTFILESIZE=5000
export HISTCONTROL=ignoredups:ignorespace:erasedups


# append to the history file, don't overwrite it
shopt -s histappend

auto_venv() {
    # don't do nothing if venv was activated once
    # by this script for for current directory
    [[ "$PWD" == "$__AUTO_VENV_LAST_PWD" ]] && return
    __AUTO_VENV_LAST_PWD="$PWD"

    # deactivate venv if leaving directory
    if [[ -n "$VIRTUAL_ENV" && "$PWD" != "$__AUTO_VENV_LAST_PWD" ]]; then
        deactivate
    fi

    # activate .venv if directory contains .venv
    if [[ -z "$VIRTUAL_ENV" && -f ".venv/bin/activate" ]]; then
        source ".venv/bin/activate"
    fi
}

# This command appends the current session's history to the .bash_history file
# each time when a new command is executed within bash.
PROMPT_COMMAND="auto_venv;history -w;$PROMPT_COMMAND"


ncmd() {
  local tmpfile
  tmpfile="$(mktemp /tmp/ncmd.XXXXXX.txt)"

  # Open Neovim and let the user type the command
  nvim +"startinsert" "$tmpfile"

  # Read the first non-empty line from the file
  local cmd
  cmd=$(grep -v '^\s*$' "$tmpfile" | head -n 1)

  # Clean up
  rm -f "$tmpfile"

  # Check if command is not empty
  if [[ -n "$cmd" ]]; then
    # Save to history
    history -s "$cmd"
    # Execute the command in the current shell
    eval "$cmd"
  fi
}


bind -r '\C-n'
bind -x '"\C-n":ncmd'


# Disable flow control to allow Ctrl-S to be used
stty -ixon
bind -x '"\C-s":clear'


edit_bash_history() {
  tmpfile=~/.history-edit-buffer.txt
  history | cut -c 8- | grep -E '^[a-zA-Z_.]' > "$tmpfile"
  nvim +"normal G" "$tmpfile"
  history -c
  history -r "$tmpfile"
}

alias j=edit_bash_history


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
    PS1='\[\033[01;34m\] \w > \[\033[00m\]'
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


set_alias() {
  local ALIAS_NAME=$1
  local ALIAS_BODY="${@:2}"

  eval "$ALIAS_NAME() { $ALIAS_BODY \$@ ; }"
}


set_alias h 'cd ~'
set_alias e 'printenv'
set_alias x 'fuck'
set_alias p 'python'
set_alias p3 'python3'
set_alias g 'rg -i'


alias al='alias'
alias s='source'
alias zj='zellij'
alias lg='lazygit'
alias r='ranger'
alias f='tere'
alias c='clear'
alias fk='history -d -2'  # drop last command from bash history
alias b='bat --color=always'
alias rel='source ~/.bashrc'
alias aws='~/programs/aws/aws-installed/v2/2.0.30/bin/aws'


venv-create() {
    ARGS_NUMBER=$#
    if [ $ARGS_NUMBER -eq 1 ]; then
	PY_VERSION=$1
	python${PY_VERSION} -m venv --upgrade-deps .venv
	source .venv/bin/activate
	return 0
    elif [ $ARGS_NUMBER -eq 2 ]; then
	TOOL=$1
	TOOL_VERSION=$2
	python3 -m venv --upgrade-deps .venv-${TOOL}
	if [ $TOOL_VERSION == "latest" ]; then
	    .venv-${TOOL}/bin/pip install ${TOOL}
	else
	    .venv-${TOOL}/bin/pip install ${TOOL}==${TOOL_VERSION}
	fi
	return 0
    fi
}
alias va='source .venv/bin/activate'
alias vd='deactivate'
alias vc='venv-create'
alias poetry='.venv-poetry/bin/poetry'
alias uv='.venv-uv/bin/uv'


tere() {
    start_time_ms=$(($(date +%s%N) / 1000000))

    local result
    result=$( \
	command tere \
	--normal-search \
	--map='ctrl-n:CursorDown,ctrl-p:CursorUp,ctrl-d:CursorDownScreen,ctrl-u:CursorUpScreen' \
	"$@" \
    )
    [ -n "$result" ] && cd -- "$result" || exit

    end_time_ms=$(($(date +%s%N) / 1000000))
    time_diff_ms=$((end_time_ms - start_time_ms))
    time_diff_s=$((time_diff_ms / 1000))

    echo "it took you ${time_diff_s} s to get to ${result}"
}

table() {
    SCRIPT_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
    SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"

    # Pass the pipe directly as stdin to the python script
    "$SCRIPT_DIR/table/.venv/bin/python3" "$SCRIPT_DIR/table/main.py" "$@"
}


ff() {
    local BASE_DIR
    BASE_DIR="${1:-.}"

    local TARGET_DIR
    TARGET_DIR=$(
	fd \
	    --type d \
	    --no-ignore \
	    --exclude .git \
	    --exclude __pycache__ \
	    --exclude node_modules \
	    --hidden \
	    . \
	    "$BASE_DIR" \
	    | sed "s|^$BASE_DIR/||" \
	    | fzf \
		--style full:rounded \
		--height 50% \
		--preview="tree -L 1 $BASE_DIR/{}"
    )
    if [ -z "$TARGET_DIR" ]; then
	return
    fi

    cd "$BASE_DIR/$TARGET_DIR" || return

    # and add correct "cd ..." command instead of "ff"
    # (idk why, but it deletes "ff" from history automatically)
    history -s "cd $BASE_DIR/$TARGET_DIR"
}


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# used to add directories/files to $PATH if they're not there
PATH_prepend() {
    local dir="$1"

    if [[ ":$PATH:" != *":$dir:"* ]]; then
        export PATH="$dir:$PATH"
    fi
}


PATH_prepend "$HOME/programs/nvim-linux-x86_64/bin"
PATH_prepend "$HOME/programs/aws/bin"
PATH_prepend "$HOME/programs/aws-azure-login"
PATH_prepend "$HOME/programs/.tfenv/bin"
PATH_prepend "$HOME/.local/kitty.app/bin"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"
export FZF_CTRL_R_OPTS="--style full:rounded"

export FZF_CTRL_T_COMMAND="\
    fd \
    --hidden \
    --no-ignore \
    --exclude __pycache__ \
    --exclude .git \
    --exclude '.venv*' \
    --exclude node_modules
"

fuzzy_files_with_hidden() {
    fd \
	--hidden \
	--no-ignore \
	--exclude __pycache__ \
	--exclude .git \
	--exclude node_modules \
    | fzf \
	--style full:rounded \
	--height=~40% \
	--layout=reverse \
	--preview='bat --color=always {}'
}

__fzf_insert_file_path() {
  local file
  file=$(fd \
    --hidden \
    --no-ignore \
    --exclude __pycache__ \
    --exclude .git \
    --exclude '.venv*' \
    --exclude node_modules \
    | fzf \
      --height=40% \
      --layout=reverse \
      --preview='bat --color=always {}' \
      --style=full:rounded
  )
  if [[ -n "$file" ]]; then
    READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$file${READLINE_LINE:$READLINE_POINT}"
    READLINE_POINT=$(( READLINE_POINT + ${#file} ))
  fi
}


__fzf_insert_file_path_with_hidden() {
  local file
  file=$(fd \
    --hidden \
    --no-ignore \
    --exclude __pycache__ \
    --exclude .git \
    --exclude node_modules \
    | fzf \
      --height=40% \
      --layout=reverse \
      --preview='bat --color=always {}' \
      --style=full:rounded
  )
  if [[ -n "$file" ]]; then
    READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$file${READLINE_LINE:$READLINE_POINT}"
    READLINE_POINT=$(( READLINE_POINT + ${#file} ))
  fi
}

bind -x '"\C-f": __fzf_insert_file_path'
bind -x '"\C-t": __fzf_insert_file_path_with_hidden'


_fzf_complete_docker() {
  _fzf_complete --multi --reverse --prompt="docker> " -- "$@" < <(
	docker ps -a --format '{{.Names}}'
  )
}

[ -n "$BASH" ] && complete -F _fzf_complete_docker -o default -o bashdefault docker


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export BASHRC_LOADED="true"

bind -x '"\C-o":nvim .'



