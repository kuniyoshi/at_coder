#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my @digits = do { chomp( my $l = <> ); split m{}, $l };

my $is = 1;

for ( my $i = 1; $i < @digits; ++$i ) {
    undef $is
        if $digits[ $i - 1 ] <= $digits[ $i ];
}

say YesNo::get( $is );

exit;
use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
