#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @s = do { chomp( my $l = <> ); split m{}, $l };

my $previous;

for my $s ( @s ) {
    if ( $previous && $s eq $previous ) {
        say YesNo::get( 0 );
        exit;
    }
    $previous = $s;
}

say YesNo::get( 1 );

exit;
use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
