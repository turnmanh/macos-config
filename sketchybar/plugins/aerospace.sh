#!/usr/bin/env bash

# Nord color palette
NORD0=0xFF2E3440   # Polar Night (darkest)
NORD1=0xFF3B4252   # Polar Night
NORD2=0xFF434C5E   # Polar Night
NORD3=0xFF4C566A   # Polar Night (lightest)
NORD4=0xFFD8DEE9   # Snow Storm (darkest)
NORD5=0xFFE5E9F0   # Snow Storm
NORD6=0xFFECEFF4   # Snow Storm (lightest)
NORD7=0xFF8FBCBB   # Frost (mint)
NORD8=0xFF88C0D0   # Frost (cyan)
NORD9=0xFF81A1C1   # Frost (blue-gray)
NORD10=0xFF5E81AC  # Frost (blue)
NORD11=0xFFBF616A  # Aurora (red)
NORD12=0xFFD08770  # Aurora (orange)
NORD13=0xFFEBCB8B  # Aurora (yellow)
NORD14=0xFFA3BE8C  # Aurora (green)
NORD15=0xFFB48EAD  # Aurora (purple)

# Padding for active and inactive workspaces
PADDING_INACTIVE=4
PADDING_ACTIVE=8

# Get focused workspace - use event variable or query aerospace
if [ -n "$FOCUSED_WORKSPACE" ]; then
    CURRENT="$FOCUSED_WORKSPACE"
else
    CURRENT=$(aerospace list-workspaces --focused)
fi

if [ "$1" = "$CURRENT" ]; then
    sketchybar --set $NAME  icon.drawing=off \
                            background.drawing=on \
                            background.color=${NORD10} \
                            background.corner_radius=5 \
                            background.height=20 \
                            background.padding_left=4 \
                            background.padding_right=4 \
                            label.color=${NORD6} \
                            label.font.style="Bold" \
                            label.font.size=14 \
                            label.padding_left=6 \
                            label.padding_right=6
else
    sketchybar --set $NAME  icon.drawing=off \
                            background.drawing=off \
                            label.color=${NORD4} \
                            label.font.style="Regular" \
                            label.font.size=14 \
                            label.padding_left=6 \
                            label.padding_right=6
fi
