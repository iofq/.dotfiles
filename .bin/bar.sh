temp_update() {
  TEMP=$(cat /sys/class/thermal/thermal_zone7/temp)
  echo $((TEMP / 1000)) > /tmp/.temp
}

cpu_update() {
  read prevtotal previdle < /tmp/.cpulast
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
  echo "$cpu%" > /tmp/.cpu
  echo $total $idle > /tmp/.cpulast
}

bat() {
   battery="$(cat /sys/class/power_supply/BAT0/capacity)"
   time=$(cat /tmp/battime)
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

update_20() {
  while :; do
    curl -s wttr.in/?format=%t | head -c 7 > /tmp/.wttr
    awk 'NR==3 {printf("%.0ddB",$4) > "/tmp/.wifi"}' /proc/net/wireless
    acpi | awk '{print $5}' > /tmp/.battime
    sleep 20
  done
}

update_3() {
  while true; do
    cpu_update
    temp_update
    sleep 3
  done
}

SLEEP_SEC=1
PAD=" | "
update_20 &
update_3 &
while true; do
  xsetroot -name "$(mem)G$PAD$(cat /tmp/.cpu)$PAD$(cat /tmp/.wifi)$PAD$(cat /tmp/.temp)°C$PAD$(bat)$PAD$(cat /tmp/.wttr)$PAD$(time_date)"
  sleep $SLEEP_SEC
done

