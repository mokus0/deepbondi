#!/bin/sh
#
#  <profile.d.sh>
#    Copyright 2007 James Cook - All Rights Reserved.
#
#	Installs a profile script on profile.d -based systems,
#	including cygwin.
#

cat <<EOF

Note - this script adds a file to /etc/profile.d
If this is not OK, or this user account does not have
permission to do so, please break now \(with Ctrl-C\)

EOF

# catch error on sleep, in case Ctrl-C only kills sleep.  Not sure
# what the standard behavior is, but I've seen similar things happen
# on some systems
sleep 5 || exit $?

cat > /etc/profile.d/deepbondi.sh <<EOF

. /deepbondi/etc/profile

EOF

echo Created /etc/profile.d/deepbondi.sh
