To create a virtual output device in PulseAudio (used by pavucontrol) that outputs to all connected hardware devices simultaneously, you can use a combined sink. This is effectively a virtual output that mirrors its audio to multiple physical outputs.

✅ Steps to Create a Virtual Output Device (Combined Sink)

1. Install required tools

Make sure pulseaudio and pavucontrol are installed.

```bash
sudo apt install pulseaudio pavucontrol
```

2. List your output devices

Run the following command to list the sink names of your physical output devices:

```bash
pactl list short sinks
```

Example output:

```bash
0   alsa_output.pci-0000_00_1b.0.analog-stereo     ...
1   alsa_output.usb-Logitech_USB_Headset-00.analog-stereo   ...
```

Take note of the sink names (like alsa_output.pci-0000_00_1b.0.analog-stereo).


3. Create a combined sink

Use pactl to create a combined sink with your target output devices:

```bash
pactl load-module module-combine-sink sink_name=combined output_properties=device description="Combined Output" slaves=sink1,sink2
```

Replace sink1,sink2 with your actual sink names.

Example:

```bash
pactl load-module module-combine-sink sink_name=combined description="All Outputs" slaves=alsa_output.pci-0000_00_1b.0.analog-stereo,alsa_output.usb-Logitech_USB_Headset-00.analog-stereo
```

This creates a new virtual device called “All Outputs”, which mirrors audio to both the analog out and USB headset.


4. Set the combined sink as your output in pavucontrol

Open pavucontrol.

Go to the "Playback" tab.

Find your application and change its output to "All Outputs" (or whatever you named the virtual sink).


5. (Optional) Auto-load at startup

To make this persistent, you can add the pactl load-module command to your startup scripts, or better yet, configure it via PulseAudio's configuration.

Edit ~/.config/pulse/default.pa and add:

```bash
load-module module-combine-sink sink_name=combined description="All Outputs" slaves=alsa_output.pci-0000_00_1b.0.analog-stereo,alsa_output.usb-Logitech_USB_Headset-00.analog-stereo
```

Then restart PulseAudio:

```bash
pulseaudio -k && pulseaudio --start
```

✅ That's it!

You now have a virtual audio output that mirrors to all selected hardware outputs. You can create more combinations using different sinks.

Let me know if you want this to work with Bluetooth devices, JACK, or PipeWire as well — steps differ slightly.

