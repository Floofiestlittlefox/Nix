#!/bin/sh
upower --monitor-detail | grep -E 'energy:' | awk '{print $1}'


#  d=$(acpi | awk -F'[:,]' '{print $3}')
#  s=$(acpi | awk -F'[:,]' '{print $2}')
#  if [[ $d != $i ]] || [[ $s != $k ]]
#  then
#    echo d
#    i=$d
#    k=$s
#  fi
#  sleep 10





