#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @xy = map { chomp; [ split m{\s} ] }
         map { scalar <> }
         1 .. $m;

my %has_input;
$has_input{ $_ }++
    for 1 .. $n;

my %no_output;
$no_output{ $_ }++
    for 1 .. $n;

my %link;
my %r_link;

for my $ref ( @xy ) {
    my( $x, $y ) = @{ $ref };
    delete $has_input{ $y };
    delete $no_output{ $x };
    $link{ $x }{ $y }++;
    $r_link{ $y }{ $x }++;
}

if ( 1 < %no_output ) {
    say YesNo::get( 0 );
    exit;
}

my @s = keys %has_input;

if ( @s != 1 ) {
    #warn "could not found start";
    say YesNo::get( 0 );
    exit;
}

my @l;

while ( @s ) {
    my $v = shift @s;
    push @l, $v;
    for my $w ( keys %{ $link{ $v } // { } } ) {
        delete $link{ $v }{ $w };
        if ( %{ $r_link{ $w } // { } } == 1 ) {
            push @s, $w;
        }
        delete $link{ $v }
            unless %{ $link{ $v } };
    }
}

if ( %link ) {
    say YesNo::get( 0 );
    exit;
}

my @whole = 1 .. $n;

say YesNo::get( 1 );
#warn join q{ }, @l;
say join q{ }, map { $_->[1] } sort { $a->[0] <=> $b->[0] } map { [ $l[ $_ ], $whole[ $_ ] ] } 0 .. $#l;

exit;

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
