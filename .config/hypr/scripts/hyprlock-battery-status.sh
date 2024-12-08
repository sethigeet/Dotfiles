#!/usr/bin/env bash

enable_battery=false
battery_charging=false

for battery in /sys/class/power_supply/*BAT*; do
  if [[ -f "$battery/uevent" ]]; then
    enable_battery=true
    if [[ $(cat /sys/class/power_supply/*/status | head -1) == "Charging" ]]; then
      battery_charging=true
    fi
    break
  fi
done

if [ $enable_battery ]; then
  current_cap="$(cat /sys/class/power_supply/*/capacity | head -1)"
  icon=""
  if [ $battery_charging ]; then
    if [ "$current_cap" -eq 100 ]; then
      icon="󰁹"
    elif [ "$current_cap" -gt 90 ]; then
      icon="󰂂"
    elif [ "$current_cap" -gt 80 ]; then
      icon="󰂁"
    elif [ "$current_cap" -gt 70 ]; then
      icon="󰂀"
    elif [ "$current_cap" -gt 60 ]; then
      icon="󰁿"
    elif [ "$current_cap" -gt 50 ]; then
      icon="󰁾"
    elif [ "$current_cap" -gt 40 ]; then
      icon="󰁽"
    elif [ "$current_cap" -gt 30 ]; then
      icon="󰁼"
    elif [ "$current_cap" -gt 20 ]; then
      icon="󰁻"
    elif [ "$current_cap" -gt 10 ]; then
      icon="󰁺"
    fi
  else
    if [ "$current_cap" -eq 100 ]; then
      icon="󰂅"
    elif [ "$current_cap" -gt 90 ]; then
      icon="󰂋"
    elif [ "$current_cap" -gt 80 ]; then
      icon="󰂊"
    elif [ "$current_cap" -gt 70 ]; then
      icon="󰢞"
    elif [ "$current_cap" -gt 60 ]; then
      icon="󰂉"
    elif [ "$current_cap" -gt 50 ]; then
      icon="󰢝"
    elif [ "$current_cap" -gt 40 ]; then
      icon="󰂈"
    elif [ "$current_cap" -gt 30 ]; then
      icon="󰂇"
    elif [ "$current_cap" -gt 20 ]; then
      icon="󰂆"
    elif [ "$current_cap" -gt 10 ]; then
      icon="󰢜"
    fi
  fi

  echo "$icon $current_cap% remaining"
fi

echo ''
