#!/bin/bash
while :; do
  curl -s wttr.in/"Madison, Wisconsin"\?%QT0 | awk 'NR==2 {print $2$3 > "/tmp/wttr"}'
  awk 'NR==3 {printf("%.0ddB",$4) > "/tmp/wifi"}' /proc/net/wireless
  sleep 20
done

