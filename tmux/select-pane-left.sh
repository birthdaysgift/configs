#!/usr/bin/env bash

zoomed=$(tmux display-message -p "#{window_zoomed_flag}")

if [[ $zoomed == "1" ]]; then

    tmp1=$(mktemp)
    tmp2=$(mktemp)
    tmux display-message -p "#{@panes_at_left}" > "$tmp1" &
    tmux display-message -p "#{pane_id}" > "$tmp2" &
    wait

    panes_at_left=$(<"$tmp1")
    current_pane_id=$(<"$tmp2")
    rm "$tmp1" "$tmp2" &

    for pane_id in $panes_at_left; do
        if [[ $pane_id == $current_pane_id ]]; then
            exit
        fi
    done
    tmux select-pane -L -Z \; switch-client -T LOCKED
    exit
fi


left_reached=$(tmux display-message -p "#{pane_at_left}")
if [[ $left_reached == "1" ]]; then
    exit
fi
tmux select-pane -L -Z \; switch-client -T LOCKED &
