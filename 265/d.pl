#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $n, $p, $q, $r ) = do { chomp( my $l = <> ); split m{\s}, $l };
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my @accs = ( 0 );

for my $a ( @a ) {
    push @accs, $accs[ -1 ] + $a;
}

for ( my $i = 0; $i < $#a; ++$i ) {
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
