#!/bin/sh
#
#  <install.sh>
#    Copyright 2007 James Cook - All Rights Reserved.
#
#

tmPrefs="$HOME/Library/Preferences"
tmSupport="$HOME/Library/Application Support/TextMate"
here=`pwd`

function link () {
	echo "$1"
	if [ -e "$2" ]; then
		echo '  target exists: skipping'
	else
		echo '  -->' "$2"
		ln -s "$1" "$2"
		if [ X"$?" != X0 ]; then
			echo Failed to link: exiting.
			exit 2
		fi
	fi
}

mkdir -p "$tmSupport"
if [ X"$?" != X0 ]; then
	echo unable to make directory "$tmSupport"
	exit 1
fi

link "$here/Bundles" "$tmSupport/Bundles"
link "$here/com.macromates.textmate.plist" "$tmPrefs/com.macromates.textmate.plist"
