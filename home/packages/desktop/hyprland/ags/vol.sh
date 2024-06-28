#!/bin/bash

vol=$(awk -F'/' '{print $2}' <(pactl get-sink-volume @DEFAULT_SINK@))
vol="${vol#"${vol%%[![:space:]]*}"}"
mute=$(awk -F':' '{print $2}' <(pactl get-sink-mute @DEFAULT_SINK@))
vol="${vol#"${vol%%[![:space:]]*}"}"

echo $vol$mute



