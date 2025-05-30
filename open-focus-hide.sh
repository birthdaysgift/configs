#!/bin/bash

# README:
#
# Note: this script works great, unless window is in tray,
# so it's good to disable tray in the settings of
# each program you want to use with this script.
#
# In order to know what PS_NAME you should pass for particular program you can:
# 1. Run `ps aux`
# 2. Search for process name at the rightmost column
#
# To get a WINDOW_CLASS you can:
# 1. Run `xprop` from terminal
# 2. Click to window
# 3. Search for WM_CLASS in xprop's output
#
# In LAUNCH_CMD you should pass cmd which is used to run program from terminal.
# If your program is run from Menu ("win" key):
# 1. Open menu and find your program
# 2. Right click on the program, go to "properties" (or smth. like that)
# 3. Find "command" or smth. like that
#
# This script accepts log file as a third argument.
# It may help you in debugging.
# For example you can set it to point to `/home/mint/code/configs/.log`.
# And then check logs in real-time via `tail -f /home/mint/code/configs/.log`


WINDOW_CLASS="$1"
LAUNCH_CMD="$2"
LOG_FILE="${3:-/dev/null}"


echo "--------------" >> ${LOG_FILE}
echo "WINDOW_CLASS = $WINDOW_CLASS" >> ${LOG_FILE}
echo "LAUNCH_CMD = $LAUNCH_CMD" >> ${LOG_FILE}


WINDOW_IDS=$(xdotool search --class "$WINDOW_CLASS")

echo "WINDOW_IDS = $WINDOW_IDS" >> ${LOG_FILE}


# Check if the program is running, if not - run it
if [ -z "$WINDOW_IDS" ]; then
    echo "program is not running, run it ..." >> ${LOG_FILE}
    `$LAUNCH_CMD &`
    exit 0
fi


# Get the currently focused window id
FOCUSED_WINDOW_ID=$(xdotool getwindowfocus)

echo "FOCUSED_WINDOW_ID = $FOCUSED_WINDOW_ID" >> ${LOG_FILE}


# iterate over all window ids associated with WINDOW_CLASS
while read -r WINDOW_ID; do
    # Check if window is focused then minimize it, or focus otherwise
    if [[ "$WINDOW_ID" == "$FOCUSED_WINDOW_ID" ]]; then
        echo "Window $WINDOW_ID is focused, hiding all related windows ..." >> ${LOG_FILE}

        while read -r WINDOW_ID_TO_HIDE; do
            echo "Hiding $WINDOW_ID_TO_HIDE" >> ${LOG_FILE}
            xdotool windowminimize "$WINDOW_ID_TO_HIDE"
        done <<< "$WINDOW_IDS"

        exit 0
    fi
done <<< "$WINDOW_IDS"


echo "window is not focused, focusing ..." >> ${LOG_FILE}
while read -r WINDOW_ID_TO_FOCUS; do
    echo "Activating $WINDOW_ID_TO_FOCUS" >> ${LOG_FILE}
    xdotool windowactivate "$WINDOW_ID_TO_FOCUS" >> ${LOG_FILE}
done <<< "$WINDOW_IDS"

