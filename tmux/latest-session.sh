#!/usr/bin/env bash

echo "Restoring tmux sesisons..."

# ensure tmux is loaded
tmux start


first_session="access"
default_session="term"

if [ ! -e /tmp/.tmux-session ]; then
    tmux new-session -A -s $first_session
    exit
else
    session=$(head -n 1 /tmp/.tmux-session)

    clients=$(tmux list-clients -t $session | wc -l)
    if (($clients > 0)); then
        tmux new-session -A -s $default_session
        exit
    fi

    tmux new-session -A -t "${session}"
    exit
fi


