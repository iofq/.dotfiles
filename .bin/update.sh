#!/bin/bash
while :; do
  curl -s wttr.in/?format=%t > /tmp/wttr
  awk 'NR==3 {printf("%.0ddB",$4) > "/tmp/wifi"}' /proc/net/wireless
  sleep 20
done
