#!/usr/bin/env perl -s
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

our $h //= 10;
our $w //= 10;

die usage( )
    if !$h || !$w;

say $h, q{ }, $w;
say q{.} x $w
    for 1 .. $h;

exit;

sub usage {
    return <<END_USAGE;
usage: $0 -h=<height> -w=<width>
END_USAGE
}
