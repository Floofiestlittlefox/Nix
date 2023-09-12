monitor=$(hyprctl cursorpos -j | jq .y)
monitor=$((monitor/1080))
echo $monitor
exec hyprctl dispatch movetoworkspace $(((monitor*10)+$1))
