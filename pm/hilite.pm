#!/usr/bin/perl
#
#  <hilite.pm>
#    Copyright 2007 James Cook - All Rights Reserved.
#
#

use strict;

package hilite;

our $st = "\033[7m";
our $en = "\033[m";

our %colors = (
	"red" => "\033[01;31m",
	"green" => "\033[01;32m",
	"yellow" => "\033[01;33m",
	"blue" => "\033[01;34m",
	"purple" => "\033[01;35m",
	"cyan" => "\033[01;36m",
	"white" => "\033[01;37m",
	"black" => "\033[0m",
);

our $bl = $colors{"black"};

sub hilite {
	my ($colorName, $text) = @_;
	my $col = $colors{lc $colorName};
	
	return ($col . $text . $bl);
}

1;
