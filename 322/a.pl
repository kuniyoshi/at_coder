#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
chomp( my $s = <> );

if ( $s =~ m{\A (.*?) ABC }msx ) {
    say 1 + length $1;
}
else {
    say -1;
}

exit;
