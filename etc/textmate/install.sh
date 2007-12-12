#!/bin/sh
#
#  <install.sh>
#    Copyright 2007 James Cook - All Rights Reserved.
#
#

tmSupport="$HOME/Library/Application Support/TextMate"
bundlePath="$tmSupport/Bundles"
here=`pwd`

mkdir -p "$bundlePath"
if [ X"$?" != X0 ]; then
	echo unable to make directory "$bundlePath"
	exit 1
fi

for bundle in Bundles/*; do
	echo "$here/$bundle"
	if [ -e "$tmSupport/$bundle" ]; then
		echo '  target exists: skipping'
	else
		echo '  -->' "$tmSupport/$bundle"
		ln -s "$here/$bundle" "$tmSupport/$bundle"
		if [ X"$?" != X0 ]; then
			echo Failed to link "$bundle": exiting.
			exit 2
		fi
	fi
done