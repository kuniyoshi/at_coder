#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min max );

my @s = do { chomp( my $l = <> ); split m{\s}, $l };

say YesNo::get( t1( ) && t2( ) && t3( ) );

exit;

sub t3 {
    my $count = grep { $_ % 25 == 0 } @s;
    return $count == @s;
}

sub t2 {
    my( $min, $max ) = ( min( @s ), max( @s ) );
    return $min >= 100 && $max <= 675;
}

sub t1 {
    my $s = join q{:}, @s;
    my $t = join q{:}, sort { $a <=> $b } @s;
    return $s eq $t;
}


use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
