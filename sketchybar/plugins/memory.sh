#!/bin/bash

MEM=$(top -l 1 | grep "PhysMem" | awk '{print $8}' | sed 's/[^0-9]*$//')
MEM_IN_GB=$(echo "scale=2; $MEM / 1000" | bc)

if [[ $MEM_IN_GB == "."* ]]; then
  MEM_IN_GB="0$MEM_IN_GB"
fi

if [[ $MEM != "" ]]; then
  sketchybar -m --set memory    icon=󰍛 \
                                label="${MEM_IN_GB}GB" \
                                drawing=on
else
  sketchybar -m --set memory drawing=off
fi
