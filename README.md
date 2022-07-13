# What this is
A quick and dirty fix for Openvario to set cpu frequency to a fixed rate (avoiding cpu frequency changes).

This fix by no means actually fixes the underlying freeze issue experienced by Openvario users. It simply stops the system from changing cpu frequencies. 
This in turn stops kernel driver cpu_freq from doing much. It seems to be this driver causing the freezes. If it doesn't do anything the freezes seem
to stop. 

So: this fix stops the freeze at the cost of fixing cpu frequency. For more information on this freeze issue check out https://github.com/Openvario/meta-openvario/issues/304

# Considerations
The script in here fixes cpu speed at 528MHz. If your board supports this speed AND you don't have a sensor board, you may be fine just using the
script as supplied. If your board doesn't support this speed, it will defaut to the nearest lower speed below 528MHz, which may be ok if you 
are not using a sensor board. 

If you are using a sensor board you should set cpu speed above 600MHz (most boards seem to be offering 720MHz) as [speeds below 600MHz apparently break
sensor reading](https://linux-sunxi.org/Cpufreq) (see section "Performance/functionality impacts").

In order to change the clock frequency in the script, edit 'fix_cpu_freq.sh' and replace 528000 with your preferred frequency. 
If you want to find out, which frequencies your board supports, you can do `cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies`.

# Installation
1. Copy "fix_cpu_freq.sh" to /usr/bin
2. make it executable by doing a `chmod a+x /usr/bin/fix_cpu_freq.sh`
3. Copy "fix_cpu_freq.service" to /etc/systemd/system
4. Do a `systemctl daemon-reload` to tell systemd about the new service
5. Do a `systemctl enable fix_cpu_freq` to enable the service
6. you can (but don't have to) `reboot` now and the cpu frequency will be set
7. alternatively you can just manually run `/usr/bin/fix_cpu_freq.sh` to set the desired frequency

# Beware
This is early days of this fix - I decided to publish this fix as many people were complaining about Openvario's freeze issues.
Don't blame me, if your Openvario goes up in flames because you fixed cpu speed at some crazy frequency. You are doing this at your own risk.
At 528MHz I have seen temperatures of around 34-35C, at 864MHz it was around 10C more. In the lab, not in the cockpit. Your mileage may vary.

If temperature is a concern for you, you can check it with `cat /sys/class/thermal/thermal_zone0/temp`.

This fix has to be reapplied with every new SD card you create. Once we better understand the freeze bug I am sure there will be fixes to 
the proper Openvario build environment.
