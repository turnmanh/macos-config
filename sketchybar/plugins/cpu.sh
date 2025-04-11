#!/bin/bash

CPU=$(top -l 1 | grep "CPU usage" | awk '{print $3}')

CPU=$(echo $CPU | sed 's/%//')
CPU=$(printf "%.2f" $CPU)

if [[ $CPU != "" ]]; then
  sketchybar -m --set cpu   icon=󰍛 \
                            label="${CPU}%" \
                            drawing=on
else
  sketchybar -m --set cpu drawing=off
fi