#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );
use Memoize;

my @WORDS = map { [ split m{} ] } qw( dream dreamer erase eraser );
memoize( "dfs" );

chomp( my $s = <> );

my @s = split m{}, $s;

say YesNo::get( !dfs( 0 ) );

exit;

sub dfs {
    my $read = shift;

    return 0
        if $read == @s;

    my $min = @s - $read;

    WORDS:
    for my $chars_ref ( @WORDS ) {
        for ( my $i = 0; $i < @{ $chars_ref }; ++$i ) {
            next WORDS
                if $read + $i >= @s;
            next WORDS
                if $s[ $read + $i ] ne $chars_ref->[ $i ];
        }

        $min = min( $min, dfs( $read + @{ $chars_ref } ) );
    }

    return $min;
}

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "YES" : "NO";
}

1;
