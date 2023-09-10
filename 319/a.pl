#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my %rate = (
    tourist => 3858,
    ksun48 => 3679,
    Benq => 3658,
    Um_nik => 3648,
    apiad => 3638,
    Stonefeang => 3630,
    ecnerwala => 3613,
    mnbvmar => 3555,
    newbiedmy => 3516,
    semiexp => 3481,
);

chomp( my $s = <> );

say $rate{ $s };

exit;
