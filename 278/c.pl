#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $q ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @queries = map { chomp; [ split m{\s} ] }
              map { scalar <> }
              1 .. $q;

my %ff;

for my $ref ( @queries ) {
    my( $operation, $from, $to ) = @{ $ref };
    if ( $operation == 1 ) {
        $ff{ $from }{ $to }++;
    }
    elsif ( $operation == 2 ) {
        delete $ff{ $from }{ $to };
    }
    elsif ( $operation == 3 ) {
        my $is = $ff{ $from }{ $to } && $ff{ $to }{ $from };
        say YesNo::get( $is );
    }
    else {
        die "Unknown operation: $operation";
    }
}

exit;

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
