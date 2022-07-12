#!/bin/bash

echo 528000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo 528000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo 528000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
echo 528000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
