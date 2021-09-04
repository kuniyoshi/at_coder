#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $s1 = <> );
chomp( my $s2 = <> );
chomp( my $s3 = <> );

my %contest = (
    "ABC" => 1,
    "ARC" => 1,
    "AGC" => 1,
    "AHC" => 1,
);

delete $contest{ $s1 };
delete $contest{ $s2 };
delete $contest{ $s3 };

say keys %contest;

exit;
