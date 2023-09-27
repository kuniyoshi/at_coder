#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( max sum );


say "g( 10 ) = ", g( 20 );

sub g {
    my $n = shift;
    return join qq{\n + }, map { f( $_ ) } 0 .. $n;
}

sub f {
    my $n = shift;
    return "f( $n )"
        if length( $n ) == 1;
    return join qq{\n + }, map { "f( $_ )" } split m{}, $n;
}


__END__

say "g( $_ ) = ", g( $_ )
    for 0 .. 20;

sub g {
    my $n = shift;
    return sum( map { f( $_ ) } 0 .. $n );
}

sub f {
    my $n = shift;
    return $n
        if length( $n ) == 1;
    return sum( split m{}, $n );
}

__END__

chomp( my $n = <> );

my @digits = reverse split m{}, $n;



# g(258) = f(0) + f(1) + f(2) + ... + f(258)
#        = g(200) + g(50) + g(8)
#        = 2424
# g(8)      = f(0) + f(1) + f(2) + ... + f(8)   = 36
# g(50)     = g(10) * 5 + g(10) * 10            = 330
# g(200)    = g(100) * 2 +                      = 1902
# g(22) = f(0) + f(1) + f(2) + ... f(22)
#       = 0
#         + 1
#         + 2
#         + 3
#         + ...
#         + 9
#         + 1 + 0
#         + 1 + 1
#         + 1 + 2
#         + ...
#         + 1 + 9
#         + 2 + 0
#         + 2 + 1
#         + 2 + 2
#
# f(0) = 0
# f(1) = 1
# f(2) = 2
# f(3) = 3
# f(4) = 4
# f(5) = 5
# f(6) = 6
# f(7) = 7
# f(8) = 8
# f(9) = 9
# f(10) = 1 + 0
# f(11) = 1 + 1
# f(12) = 1 + 2
# f(13) = 1 + 3
# f(14) = 1 + 4
# f(15) = 1 + 5
# f(16) = 1 + 6
# f(17) = 1 + 7
# f(18) = 1 + 8
# f(19) = 1 + 9
# f(20) = 2 + 0
# f(21) = 2 + 1
# f(22) = 2 + 2
# ...
# f(29) = 2 + f(9)
# ...
# f(30) = 3 + f(0)
# ...
# f(99) = 9 + f(9)
# ...
# f(100) = 1 + f(10) + f(0)
# f(101) = 1 + f(10) + f(1)
# f(102) = 1 + f(10) + f(2)
# ...
# f(109) = 1 + f(10) + f(9)
# f(110) = 1 + f(11) + f(0)
# ...
# f(1111) = 1 + f(111) + f(11) + f(1)
for ( my $i = 0; $i < @digits; ++$i ) {
    $sum += $digits[ $i ] * 10 ** max( 0, @digits - $i - 2 );
    $sum += $digits[ $i ] * 10 ** ( max( 0, @digits - $i - 1 ) * $digits[ 
}


exit;
