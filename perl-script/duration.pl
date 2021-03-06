#!/usr/bin/perl

# Function : Calculate number of days from a baseline (e.g. 1970-01-01)

use warnings;
use strict;
use Date::Calc qw(Delta_Days);
use Time::Piece;
use FindBin qw($Bin);

my $now=localtime;
my @past=();

if (defined $ARGV[0]) {
    if (@ARGV < 3) {
        @past=($1,$2,$3) if
        $ARGV[0]=~m/^([0-9]{4})([0-9]{2})([0-9]{2})$/ or
        $ARGV[0]=~m/^([0-9]{4})[^0-9]([0-9]{1,2})[^0-9]([0-9]{1,2})$/
    } else {
        @past=@ARGV[0..2];
    }
} else {
    my $base = $Bin."/BASE";
    if (-e $base) {
        open FILE, '<', $base or die;
        @past = split(' ', <FILE>);
        close FILE;
    } else {
        @past=qw/1970 1 1/;
    }
}

print Delta_Days(@past,$now->year,$now->mon,$now->mday),"\n" if @past!=0;
