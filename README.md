# internet_monitor

This is a simple *internet-connection* monitoring script for raspberry pi.
I run this on a Raspberry Pi4 Model-B.

I run this as a systemd service using the given systemd unit file.


NOTES:
---
0. Ping response from some common sites are used as an evidence for internet connectivity, Since DNS names are used, even DNS downtimes will be counted as internet downtimes.
1. Change the hardcoded paths to match your system.
2. There is no log-rotation in this, But it is farely easy to add using logrotated
