#!/usr/bin/bash

# Unload any previous setup
for mod in $(pactl list short modules | grep -E "module-null-sink|module-loopback" | awk '{print $1}'); do
    pactl unload-module "$mod"
done

# Create a null sink (virtual output)
null_sink_index=$(pactl load-module module-null-sink sink_name=combined_inputs sink_properties=device.description=Combined_Inputs)

# Get the monitor source of the null sink
monitor_source="combined_inputs.monitor"

# Get all source names (excluding monitor sources and virtual ones)
sources=$(pactl list short sources | grep -v "monitor" | awk '{print $2}')

# Loop through each physical source and loop it into the null sink
for source in $sources; do
    pactl load-module module-loopback source="$source" sink=combined_inputs
done

echo "Combined input available as source: $monitor_source"


pactl set-default-source combined_inputs.monitor
