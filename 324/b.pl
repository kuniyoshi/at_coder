#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );

while ( ( $n % 2 ) == 0 ) {
    $n /= 2;
}

while ( ( $n % 3 ) == 0 ) {
    $n /= 3;
}

say YesNo::get( $n == 1 );


exit;
use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
