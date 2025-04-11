#!/bin/bash

# Script to check for connected Bluetooth headsets
# Exit codes:
#   0 - At least one Bluetooth headset is connected
#   1 - No Bluetooth headsets are connected
#   2 - Error running system_profiler command

echo "Checking for connected Bluetooth headsets..."

# Run system_profiler to get Bluetooth data
bluetooth_data=$(system_profiler SPBluetoothDataType 2>/dev/null)
exit_code=$?

# Check if system_profiler command succeeded
if [ $exit_code -ne 0 ]; then
    echo "Error: Failed to retrieve Bluetooth data. Exit code: $exit_code"
    exit 2
fi

# Initialize flag to track if we found any headsets
found_headset=false

# Create a temporary file to store results
temp_file=$(mktemp)

# Extract the Connected section (stop when we hit "Not Connected:" section)
in_connected_section=false
device_name=""
device_details=""

# Process the Bluetooth data line by line
while IFS= read -r line; do
    # Check for section headers
    if [[ "$line" == *"Connected:"* && "$line" != *"Not Connected:"* ]]; then
        in_connected_section=true
        continue
    elif [[ "$line" == *"Not Connected:"* ]]; then
        in_connected_section=false
        # Process the last device if we were in a device section
        if [[ -n "$device_name" && "$device_details" == *"Minor Type: Headset"* ]]; then
            echo "Found connected headset: $device_name" | tee -a "$temp_file"
        fi
        device_name=""
        device_details=""
        continue
    fi

    # Skip if not in connected section
    if [[ "$in_connected_section" != true ]]; then
        continue
    fi

    # Check for new device (indented with spaces followed by a name)
    if [[ "$line" =~ ^[[:space:]]{4}[^[:space:]] && ! "$line" =~ ^[[:space:]]{6,} ]]; then
        # Process the previous device if it exists
        if [[ -n "$device_name" && "$device_details" == *"Minor Type: Headset"* ]]; then
            echo "Found connected headset: $device_name" | tee -a "$temp_file"
        fi
        
        # Extract new device name (remove trailing colon if present)
        device_name=$(echo "$line" | sed 's/^[[:space:]]*//;s/:$//')
        device_details=""
    else
        # Accumulate device details
        device_details+="$line"
    fi
done <<< "$bluetooth_data"

# Process the last device if we were in a device section
if [[ "$in_connected_section" == true && -n "$device_name" && "$device_details" == *"Minor Type: Headset"* ]]; then
    echo "Found connected headset: $device_name" | tee -a "$temp_file"
fi

# Check if any headsets were found by checking the temp file
if [ -s "$temp_file" ]; then
    found_headset=true
else
    found_headset=false
fi

# Clean up the temporary file
rm -f "$temp_file"

# Final output and exit code based on whether headsets were found
if [ "$found_headset" = true ]; then
    echo "Success: Bluetooth headset(s) connected."
    exit 0
else
    echo "No Bluetooth headsets are currently connected."
    exit 1
fi

