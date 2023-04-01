#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $x ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my %count;
$count{ $_ }++
    for @a;

for my $a ( keys %count ) {
    if ( $count{ $a + $x } ) {
        say YesNo::get( 1 );
        exit;
    }
}

say YesNo::get( 0 );

exit;
use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
