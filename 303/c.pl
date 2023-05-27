#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $m, $h, $k ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @s = do { chomp( my $l = <> ); split m{}, $l };
my @items = map { chomp; [ split m{\s} ] }
            map { scalar <> }
            1 .. $m;

my %item;

for my $ref ( @items ) {
    my( $x, $y ) = @{ $ref };
    $item{ $x }{ $y }++;
}

my $x = 0;
my $y = 0;
my $hp = $h;

my %delta = (
    R => [ 1, 0 ],
    L => [ -1, 0 ],
    U => [ 0, 1 ],
    D => [ 0, -1 ],
);

for my $move ( @s ) {
    my $delta = $delta{ $move }
        or die "No move found: [$move]";
    $x += $delta->[0];
    $y += $delta->[1];
    $hp--;

    if ( $hp < 0 ) {
        say YesNo::get( 0 );
        exit;
    }

    if ( $item{ $x }{ $y } && $hp < $k ) {
        $hp = $k;
        delete $item{ $x }{ $y };
    }
}

say YesNo::get( 1 );

exit;
use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
