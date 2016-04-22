#!/bin/sh

sysctl -w net.inet.ip.forwarding=1
sysctl -w net.inet.ip.fw.enable=1

#disables pfctl
pfctl -d

sleep 1

#flushes all pfctl rules
pfctl -f /private/etc/pf.anchors/org.user.forwarding -f /private/etc/pf.anchors/org.user.netflixblock -e

pfctl -E
