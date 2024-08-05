#!/bin/bash

out=$(pactl list short sinks | awk -F'\t' '{print $1}')
if [ $1 = "out" ]
then
  echo $out
fi
if [ $1 = "in" ]
then
  in=$(pactl list short sources | awk -F'\t' '{print $1}')
  in=$(echo ${in#"$out"})
  echo $in
fi

if [ $1 = "name" ]
then
  echo $(pw-cli info $2 | grep device.product.name) #| sed 's/(device.product.name|")//g')
fi
