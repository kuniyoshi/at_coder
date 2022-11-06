#!/opt/local/bin/perl5.26
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min all sum );

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my $count = answer( ) // -1;

say $count;

exit;

sub answer {
    my %counts;
    my @bases;

    for my $i ( 0 .. $#a ) {
        my $value = $a[ $i ];

        for my $dividor ( 2, 3 ) {
            $counts{ $dividor }[ $i ] = 0;

            while ( ( $value % $dividor ) == 0 ) {
                $value /= $dividor;
                $counts{ $dividor }[ $i ]++;
            }
        }

        push @bases, $value;
    }

    return
        unless all { $_ == $bases[0] } @bases;

    for my $dividor ( 2, 3 ) {
        my $min = min( @{ $counts{ $dividor } } );
        $_ -= $min
            for @{ $counts{ $dividor } };
    }

    return sum( map { @{ $_ } } values %counts );
}
