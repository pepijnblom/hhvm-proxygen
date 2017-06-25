#!/bin/sh
# `/sbin/setuser memcache` runs the given command as the user `memcache`.
# If you omit that part, the command will be run as root.
exec /sbin/setuser www-data /usr/bin/hhvm -m server -c /etc/hhvm/server.ini -c /etc/hhvm/site.ini 