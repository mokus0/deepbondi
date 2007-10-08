#!/bin/sh
#
#  <cygwin.sh>
#    Copyright 2007 James Cook - All Rights Reserved.
#
#

echo Note - this script adds a file to /etc/profile.d
echo If this is not OK, or this user account does not have
echo permission to do so, please break now \(with Ctrl-C\)

sleep 5

cat > /etc/profile.d/deepbondi.sh <<EOF

. /deepbondi/etc/profile

EOF