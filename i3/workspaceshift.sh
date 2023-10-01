monitor=$(xdotool getmouselocation | awk '{printf $2}' | sed 's/y://')
monitor=$((monitor/1080))
exec i3 move container to workspace $(((monitor*10)+$1))
