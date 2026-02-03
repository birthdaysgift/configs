#!/usr/bin/env bash

zoomed=$(tmux display-message -p "#{window_zoomed_flag}")

if [[ $zoomed -eq "1" ]]; then
    tmux resize-pane -Z \; switch-client -T LOCKED &
    exit
fi

tmp1=$(mktemp)
tmp2=$(mktemp)
tmp3=$(mktemp)
tmp4=$(mktemp)

tmux list-panes -F "#{pane_id}" -f "#{pane_at_left}" > "$tmp1" &
tmux list-panes -F "#{pane_id}" -f "#{pane_at_top}" >"$tmp2" &
tmux list-panes -F "#{pane_id}" -f "#{pane_at_bottom}" >"$tmp3" &
tmux list-panes -F "#{pane_id}" -f "#{pane_at_right}" >"$tmp4" &

wait

tmux resize-pane -Z \; switch-client -T LOCKED &

panes_at_left=$(<"$tmp1")
panes_at_top=$(<"$tmp2")
panes_at_bottom=$(<"$tmp3")
panes_at_right=$(<"$tmp4")

rm "$tmp1" "$tmp2" "$tmp3" "$tmp4" &

# this is done in the background
# since we got panes info we don't have to wait for these commands
tmux set -w @panes_at_left "$panes_at_left" &
tmux set -w @panes_at_top "$panes_at_top" &
tmux set -w @panes_at_bottom "$panes_at_bottom" &
tmux set -w @panes_at_right "$panes_at_right" &
