# Internet Connection Monitor

This is a simple *internet-connection* monitoring script for raspberry pi.
I run this on a Raspberry Pi4 Model-B. 
(A bit of context: I find myself with a pesky connection of late, and I need this to talk to the ISP.)

I run this as a systemd service using the given systemd unit file.

# How to test

The working can be tested by temporarily switching the default gateway to another reachable IP in your network (This shouldn't be your router)

It is a good idea to first note down your current default gateway:

`sudo ip route list`

Then remove the gatway:

`sudo ip route delete default via <orig-default-gateway-ip> dev <ethernet-iface-typically-eth0>`

Then add the new route:

`sudo ip route delete default via <another-reachable-ip-on-your-nw> dev eth0`

The log file should now show: 'Internet is DOWN.'



NOTES:
---
- Ping response from some common sites are used as an evidence for internet connectivity, Since DNS names are used, even DNS downtimes will be counted as internet downtimes.
- Change the hardcoded paths to match your system.
- There is no log-rotation in this, But it is farely easy to add using logrotated

# Systemd service configuration

- chmod +x internet_monitor.sh
- Copy internet-monitor.unit to /lib/systemd/system/
- systemctl daemon-reload
- systemctl enable internet-monitor
- systemctl start internet-monitor
