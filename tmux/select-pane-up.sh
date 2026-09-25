#!/usr/bin/env bash

zoomed=$(tmux display-message -p "#{window_zoomed_flag}")

if [[ $zoomed == "1" ]]; then

    tmp1=$(mktemp)
    tmp2=$(mktemp)
    tmux display-message -p "#{@panes_at_top}" > "$tmp1" &
    tmux display-message -p "#{pane_id}" > "$tmp2" &
    wait

    panes_at_top=$(<"$tmp1")
    current_pane_id=$(<"$tmp2")
    rm "$tmp1" "$tmp2" &

    for pane_id in $panes_at_top; do
        if [[ $pane_id == $current_pane_id ]]; then
            exit
        fi
    done
    tmux select-pane -U -Z \; switch-client -T LOCKED
    exit
fi


top_reached=$(tmux display-message -p "#{pane_at_top}")
if [[ $top_reached == "1" ]]; then
    exit
fi
tmux select-pane -U -Z \; switch-client -T LOCKED &
