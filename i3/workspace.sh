monitor=$(xdotool getmouselocation | awk '{printf $2}' | sed 's/y://')
echo $monitor
monitor=$((monitor/1080))
echo $monitor
exec i3 workspace $((((monitor*10)+$1)))
