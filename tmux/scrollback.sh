#!/usr/bin/env bash


# thanks
#    https://github.com/omerxx/tmux-buffex/tree/main
# for the idea


SCROLLBACK_FILE="$HOME/.tmux-scrollback"

# tmux capture-pane -S -10000
# tmux save-buffer "$SCROLLBACK_FILE"

tmux capture-pane -p -S - -e > $SCROLLBACK_FILE

# tmux new-window "nvim $SCROLLBACK_FILE && tmux load-buffer $SCROLLBACK_FILE && tmux delete-buffer && rm $SCROLLBACK_FILE"
tmux new-window -n "_scrollback" " \
    ~/programs/nvim-linux-x86_64/bin/nvim $SCROLLBACK_FILE \
    && tmux load-buffer $SCROLLBACK_FILE \
    && tmux delete-buffer \
    && rm $SCROLLBACK_FILE \
"

