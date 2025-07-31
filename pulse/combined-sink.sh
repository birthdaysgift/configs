#!/bin/bash


# This script will create a virtual sink
# called "All Outputs" that mirrors to
# all connected output devices.


# Get list of all sink names
sinks=$(pactl list short sinks | awk '{print $2}' | paste -sd "," -)

# Remove existing combined sink if any
existing=$(pactl list short modules | grep module-combine-sink | awk '{print $1}')
[ -n "$existing" ] && pactl unload-module "$existing"

# Create new combined sink with all available sinks
pactl load-module module-combine-sink sink_name=all_outputs slaves=$sinks description="All Outputs"

