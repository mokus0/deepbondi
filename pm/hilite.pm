#!/usr/bin/perl
#
#  <hilite.pm>
#    Copyright 2007 James Cook - All Rights Reserved.
#
#

use strict;

package hilite;

our $st = "\033[";
our $en = "m";

our %modes = (
	"default" => "0",
	"normal" => "0",
	"bold" => "1",
	"nobold" => "22",
	"underline" => "4",
	"nounderline" => "24",
	"blink" => "5",
	"noblink" => "25",
	"inverse" => "7",
	"noinverse" => "27",
);

our $fgBase = "3";
our $bgBase = "4";

our %colors = (
	"red" => "1",
	"green" => "2",
	"yellow" => "3",
	"blue" => "4",
	"purple" => "5",
	"cyan" => "6",
	"white" => "7",
);

our $resetColor = color();

sub color {
	my ($fgName, $bgName, $modeName) = @_;
	
	my $fg;
	if (defined $fgName) {
		if (defined $colors{lc $fgName}) {
			$fg = $fgBase . $colors{lc $fgName};
		} else {
			return undef;
		}
	}
	
	my $bg;
	if (defined $bgName) {
		if (defined $colors{lc $bgName}) {
			$bg = $bgBase . $colors{lc $bgName};
		} else {
			return undef;
		}
	}
	
	my $mode;
	if (defined $modeName){
		if (defined $modes{lc $modeName}) {
			$mode = $modes{lc $modeName};
		} else {
			return undef;
		}
	} else {
		$mode = "0;";
	}
	
	my @seq = grep {defined} ($mode, $fg, $bg);
	my $seq = join ";", @seq;
	
	return "${st}${seq}${en}";
}

sub hilite {
	my ($colorName, $text) = @_;
	my $col = color (lc $colorName);
	
	return ($col . $text . $resetColor);
}

1;
