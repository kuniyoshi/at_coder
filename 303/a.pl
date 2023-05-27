#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
chomp( my $s = <> );
chomp( my $t = <> );

$s =~ s{1}{l}g;
$s =~ s{0}{o}g;
$t =~ s{1}{l}g;
$t =~ s{0}{o}g;

say YesNo::get( $s eq $t );

#my @s = do { chomp( my $l = <> ); split m{}, $l };
#my @t = do { chomp( my $l = <> ); split m{}, $l };
#
#my $is_similar = 1;
#
#for my $i ( 0 .. $n - 1 ) {
#    next
#        if $s[ $i ] eq $t[ $i ];
#    my $s = $s[ $i ] eq q{1} ? q{l} : $s[ $i ];
#    my $t = $t[ $i ] eq q{1} ? q{l} : $t[ $i ];
#    $s = $s eq q{0} ? q{o} : $s;
#    $t = $t eq q{0} ? q{o} : $t;
#    next
#        if $s eq $t;
#    undef $is_similar;
#}
#
#say YesNo::get( $is_similar );

exit;
use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
