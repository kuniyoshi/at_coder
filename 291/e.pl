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

my %isnt_max;

my %link;

for my $ref ( @xy ) {
    my( $x, $y ) = @{ $ref };
    $isnt_max{ $x }++;
    $link{ $y }{ $x }++;
}

my @s = grep { !$isnt_max{ $_ } } 1 .. $n;
my @l;

if ( !@s ) {
    say YesNo::get( 0 );
    exit;
}

while ( @s ) {
    if ( @s > 1 ) {
        say YesNo::get( 0 );
        exit;
    }
    my $v = shift @s;
    push @l, $v;
    for my $w ( keys %{ $link{ $v } // { } } ) {
        if ( $isnt_max{ $w } ) {
            $isnt_max{ $w }--;
            push @s, $w
                unless $isnt_max{ $w };
        }
    }
}

my @whole = 1 .. $n;

say YesNo::get( 1 );
warn join q{ }, @l;
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
