#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @s = do { chomp( my $l = <> ); split m{}, $l };

my $p = [ 0, 0 ];

my %count = ( 0 => { 0 => 1 } );

my %move = (
    R => [ 1, 0 ],
    L => [ -1, 0 ],
    U => [ 0, 1 ],
    D => [ 0, -1 ],
);

for my $direction ( @s ) {
    $p->[0] += $move{ $direction }[0];
    $p->[1] += $move{ $direction }[1];
    $count{ $p->[0] }{ $p->[1] }++;
}

say YesNo::get( test( ) );


exit;

sub test {
    for my $x ( keys %count ) {
        my $is = grep { $_ > 1 } values %{ $count{ $x } };
        return 1
            if $is;
    }

    return;
}

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
