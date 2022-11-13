#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @s = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $n;

my $is_first_character = all( [ qw( H D C S ) ], [ map { $_->[0] } @s ] );
my $is_second_character = all( [ qw( A 2 3 4 5 6 7 8 9 T J Q K ) ], [ map { $_->[1] } @s ] );

my %count;
$count{ join q{}, @{ $_ } }++
    for @s;

my $is_unique = scalar( %count ) == $n;

say YesNo::get( $is_first_character && $is_second_character && $is_unique );

exit;

sub all {
    my $valids_ref = shift;
    my $items_ref = shift;
    my $count = grep { any( $_, $valids_ref ) } @{ $items_ref };
    return $count == @{ $items_ref };
}

sub any {
    my $item = shift;
    my $items_ref = shift;
    return scalar grep { $_ eq $item } @{ $items_ref };
}

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
