#!/usr/bin/env bash

tmux new-window -n "python-scratch" -c "/home/mint/code/python-scratch/"
tmux send-keys 'nvim' C-m

tmux split-window -v -c "#{pane_current_path}"
tmux send-keys 'echo main.py | entr -c python3 main.py' C-m

tmux select-pane -U -Z
