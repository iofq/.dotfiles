#!/bin/bash
trap \
 "{ pkill -P $$ ; exit 255; }" \
 SIGINT SIGTERM ERR EXIT

bat() {
   battery="$(cat /sys/class/power_supply/BAT0/capacity)"
   time=$(cat /tmp/.battime)
   if [[ $(cat /sys/class/power_supply/BAT0/status) == "Charging" ]]; then
     echo "$battery%+"
   else
     echo "$time, $battery%$charge"
   fi
}

time_date() {
 	FORMAT="%a %m.%d.%y %T"
 	DATE=`date "+${FORMAT}"`
 	echo "${DATE}"
 }

mem() {
  echo "scale=2; $(free -m | sed -n 2p | awk '{print $3 + $5}') / 1000" | bc
}

vol() {
    muted=$(amixer get Master | grep off)
    if [[ $muted != "" ]]; then
        echo "muted"
    else
        amixer get Master | grep -m1 -Po "\d{1,3}%"
    fi
}

temp_update() {
  TEMP=$(cat /sys/class/thermal/thermal_zone8/temp)
  echo $((TEMP / 1000)) 
}

cpu_update() {
  read prevtotal previdle < /tmp/.cpulast
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  [[ $prevtotal == 0 ]] && prevtotal=1
  cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
  echo $total $idle > /tmp/.cpulast
  echo "$cpu%" 
}

calc(){ awk "BEGIN { print "$*" }"; }
mhz_update() {
  mhz=$(cat /proc/cpuinfo | grep 'cpu MHz' | awk '{print $4}' | head -n1 | cut -d "." -f 1)
  echo "$(calc $mhz/1000 | awk '{ printf "%1.2f\n", $0 }') GHz" 
}

update_3() {
  while true; do
    cpu_update > /tmp/.cpu
    temp_update > /tmp/.temp
    mhz_update > /tmp/.mhz
    if ping -W 1 -c 1 10.6.0.1 > /dev/null; then
      echo "wg0" > /tmp/.online
    else
      echo "?" > /tmp/.online
    fi
    sleep 3
  done
}
update_20() {
  while :; do
    curl -s wttr.in/?format=%t | head -c 7 > /tmp/.wttr
    awk 'NR==3 {printf("%.0ddB",$4) > "/tmp/.wifi"}' /proc/net/wireless
    acpi | awk '{print $5}' > /tmp/.battime
    sleep 20
  done
}

SLEEP_SEC=1
PAD=" | "
update_20 &
update_3 &
while true; do
    xsetroot -name "$(mem)G$PAD$(cat /tmp/.cpu)$PAD$(cat /tmp/.mhz)$PAD$(cat /tmp/.temp)°C$PAD$(cat /tmp/.wifi), $(cat /tmp/.online)$PAD$(vol)$PAD$(bat)$PAD$(cat /tmp/.wttr), $(time_date)"
  sleep $SLEEP_SEC
done
