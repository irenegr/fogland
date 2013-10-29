#!/bin/bash
# test if /sys/class/power_supply/BAT1/capacity exists, avoiding console spam on desktops

if test -e /sys/class/power_supply/BAT0/capacity; then
  cat /sys/class/power_supply/BAT0/capacitycat /sys/class/power_supply/BAT0/capacity >&2
else
  exit 1
fi