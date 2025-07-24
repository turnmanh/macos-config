#!/usr/bin/env bash


# Nord color palette
NORD0=0xFF2E3440
NORD1=0xFF3B4252
NORD2=0xFF434C5E
NORD3=0xFF4C566A
NORD4=0xAAD8DEE9
NORD5=0xE5E9F0
NORD6=0xECEFF4
NORD7=0x8FBCBB
NORD8=0x88C0D0
NORD9=0xFF81A1C1
NORD10=0xFF5E81AC
NORD11=0xFFBF616A
NORD12=0xFFD08770
NORD13=0xFFEBCB8B
NORD14=0xFFA3BE8C
NORD15=0xFFB48EAD

# Padding for active and inactive workspaces
PADDING_INACTIVE=1
PADDING_ACTIVE=6

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME  label.color=${NORD11} \
                            label.font.style="Bold" \
                            label.font.size=20 \
                            label.padding_left=${PADDING_ACTIVE} \
                            label.padding_right=${PADDING_ACTIVE}
else
    sketchybar --set $NAME  label.color=${NORD3} \
                            label.font.style="Thin" \
                            label.font.size=16 \
                            label.padding_left=${PADDING_INACTIVE} \
                            label.padding_right=${PADDING_INACTIVE} 
fi
