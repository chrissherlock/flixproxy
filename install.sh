#!/bin/sh

# copy over the packet forwarding rules to forward all
# dns traffic to the correct DNS servers
sudo cp org.user.forwarding /private/etc/pf.anchors/

# block the Netflix servers, as advised by GetFlix:
# https://www.getflix.com.au/netflix-update
sudo cp org.user.netflixblock /private/etc/pf.anchors/

# allow the SOCKS5 server to accept connections
sudo cp org.user.socks5 /private/etc/pf.anchors/

# check to see if the pf.conf file has already been configured
if [ -z $(grep /private/etc/pf.conf "rdr-anchor \"org.user.forwarding\"") ]; then
    cat pf.rules.conf >> /private/etc/pf.conf
fi

# proxy.pac to allow automatic configuration on Apple devices
mkdir -p /usr/local/socks5/
cp proxy.pac /usr/local/socks5/

# Copy over the launchers
sudo cp *.plist /Library/LaunchDaemons/

# start the DNS port forwarder
sudo launchctl load /Library/LaunchDaemons/org.user.forwarding.plist

# start the SOCKS5 server
sudo launchctl load /Library/LanchDaemons/org.users.socks5.plist
