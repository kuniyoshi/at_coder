#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $t = <> );
my $answer = f( f( f( $t ) + $t ) + f( f( $t ) ) );

say $answer;

exit;

sub f {
    my $x = shift;
    return $x * $x + 2 * $x + 3;
}
