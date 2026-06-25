#!/usr/bin/env bash

# Check if headphones/audio devices are connected
# Check for Bluetooth or headphone output device
AUDIO_OUTPUT=$(system_profiler SPAudioDataType 2>/dev/null | grep -B 10 "Default Output Device: Yes" | grep -E "Transport: Bluetooth|^\s+.*[Hh]eadphone.*:|^\s+.*AirPods.*:|^\s+.*Ear.*:")

if [ -n "$AUDIO_OUTPUT" ]; then
    sketchybar --set headphones icon="󰋋" drawing=on
else
    sketchybar --set headphones drawing=off
fi
