# #!/bin/bash

# Function to check for a connected Bluetooth headset
check_bluetooth_headset() {
  local json_data="$1"

  # Use jq to filter for connected devices with minor type "Headset"
  if jq -e '.SPBluetoothDataType[0].device_connected[] | .[] | select(.device_minorType == "Headset")' <<< "$json_data" > /dev/null 2>&1; then
    echo "Bluetooth headset connected."
  # else
    # echo "No connected Bluetooth headset found."
  fi
}

# Capture the output of system_profiler
bluetooth_json=$(system_profiler SPBluetoothDataType -json)

# Pass the captured JSON to the function
DEVICES=$(check_bluetooth_headset "$bluetooth_json")

if [ "$DEVICES" = "" ]; then
  sketchybar -m --set $NAME drawing=off
else
  sketchybar -m --set $NAME drawing=on
fi
