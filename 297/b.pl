#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my @s = do { chomp( my $l = <> ); split m{}, $l };

my @indexes = map { $_ + 1 } grep { $s[ $_ ] eq q{B} } 0 .. $#s;
my $cond_1 = ( $indexes[0] ^ $indexes[1] ) & 1;

my @chars = grep { $_ eq q{K} || $_ eq q{R} } @s;
my $cond_2 = $chars[1] eq q{K};


say YesNo::get( $cond_1 && $cond_2 );



exit;
use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
