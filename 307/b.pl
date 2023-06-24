#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

#die is_cycle( qw( a a a ), qw( a a ) );

chomp( my $n = <> );
my @s = map { chomp; [ split m{} ] }
        map { scalar <> }
        1 .. $n;

for my $i ( 0 .. $n - 1 ) {
    for my $j ( 0 .. $i - 1 ) {
        if ( is_cycle( @{ $s[ $i ] }, @{ $s[ $j ] } ) || is_cycle( @{ $s[ $j ] }, @{ $s[ $i ] } ) ) {
            say YesNo::get( 1 );
            exit;
        }
    }
}

say YesNo::get( 0 );

exit;

sub is_cycle {
    my @chars = @_;
    my @reverse = reverse @chars;

    #    return join( q{}, @chars ) eq join( q{}, @reverse );

    for my $i ( 0 .. int( @chars / 2 ) ) {
        #        warn "$chars[ $i ] eq $chars[ $#chars - $i ]";
        return
            if $chars[ $i ] ne $chars[ $#chars - $i ];
    }

    return 1;
}
use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
