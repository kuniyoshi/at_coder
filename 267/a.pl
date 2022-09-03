#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $s = <> );
my %days = (
    Monday => 5,
    Tuesday => 4,
    Wednesday => 3,
    Thursday => 2,
    Friday => 1,
);

say $days{ $s };

exit;
