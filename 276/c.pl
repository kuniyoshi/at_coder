#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min max );

chomp( my $n = <> );
my @p = do { chomp( my $l = <> ); split m{\s}, $l };

my @digits = ( 0, @p );

my( $index, $previous ) = get_index( );

my @result = @digits[ 1 .. $index ];
my @remain = @digits[ $index + 1 .. $#digits ];

while ( @remain ) {
    my $max;

    if ( defined $previous ) {
        $max = max( grep { $_ < $previous } @remain );
        undef $previous;
    }
    else {
        $max = max( @remain );
    }

    @remain = grep { $_ != $max } @remain;
    push @result, $max;
}

say join q{ }, @result;


exit;

sub get_index {
    my @candidates;
    my $index = $#digits;

    while ( $index ) {
        push @candidates, $digits[ $index ];
        $index--;

        die "Could not decrement"
            if $index < 0;

        my $min = min( @candidates );

        if ( $min != $candidates[-1] ) {
            return $index, $candidates[-1];
        }
    }
}
