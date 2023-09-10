#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $q = <> );
my @queries = map { chomp; $_ }
              map { scalar <> }
              1 .. $q;

for my $query ( @queries ) {
    say YesNo::get( is_prime( $query ) );
}

exit;

sub is_prime {
    my $n = shift;

    for ( my $i = 2; $i <= sqrt $n; ++$i ) {
        return
            if $n % $i == 0;
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
