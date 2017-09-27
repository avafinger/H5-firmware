#!/bin/sh
#
# Simple script to print some health data for H5 series.
# Based on lonsleep and tkaiser work.
#
# Run this script like `sudo h5-monitor.sh -w`.
#
# ********************************
# *** Works on Mailine kernel! ***
# ********************************
#
# Prints vital info every 2 secs. Try to not be intrusive.
#	 

set -e

if [ "$(id -u)" -ne "0" ]; then
	echo "This script requires root."
	exit 1
fi

print() {
	printf "%-15s: %s %s\n" "$1" "$2 $3" "$4"
}

cpu_frequency() {
	local cur=$(cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq)
	local mhz=$(awk "BEGIN {printf \"%.f\",$cur/1000}")
	print "CPU freq" $mhz "MHz"
}

scaling_govenor() {
	local gov=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
	print "Governor" $gov
}

cpu_count() {
	local cpus=$(grep -c processor /proc/cpuinfo)
	print "CPU count" $cpus
}

vcore_voltage() {
	local uv=$(cat /sys/devices/platform/gpio-regulator/regulator/regulator.3/microvolts)
	local v=$(awk "BEGIN {printf \"%.f\",$uv/1000000}")
	print "Core voltage" $v "V"
}

soc_temp() {
	local temp=$(cat /sys/devices/virtual/thermal/thermal_zone0/temp)
        local v=$(awk "BEGIN {printf \"%.f\",$temp/1000}")
	print "SOC Temp" $v "C"
}

cooling_state() {
	local state=$(cat /sys/devices/virtual/thermal/cooling_device0/cur_state)
	print "Cooling state" $state
}

cooling_limit() {
	local limit=$(cat /sys/devices/soc.0/cpu_budget_cool.16/roomage)
	print "Cooling limit" $limit
}

all() {
#        echo 1 > /sys/class/gpio_sw/normal_led/data 
	cpu_frequency
	cpu_count
	scaling_govenor
	#vcore_voltage
	soc_temp
	#cooling_state
	#cooling_limit
#	echo 0 > /sys/class/gpio_sw/normal_led/data 
}

usage() {
	echo "Usage: $0 [-w] [-h]"
}

WATCH=""
for i in "$@"; do
	case $i in
	-w)
		WATCH=1
		shift
		;;
	-h|--help)
		usage
		exit 0
		;;
	*)
		usage
		exit 1
		;;
	esac
done

if [ -n "$WATCH" ]; then
	exec watch -n2 "$0"
else
	all
fi
