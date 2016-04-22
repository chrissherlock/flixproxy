#!/bin/sh
cd /usr/local/socks5
python -m SimpleHTTPServer 8081
ssh -D 8080 -f -q -N chris@localhost
