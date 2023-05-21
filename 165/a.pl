#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $k = <> );
my( $a, $b ) = do { chomp( my $l = <> ); split m{\s}, $l };

if ( $a % $k == 0 ) {
    say "OK";
    exit;
}

if ( $b % $k == 0 ) {
    say "OK";
    exit;
}

my $da = int( $a / $k );
my $db = int( $b / $k );

say $da != $db ? "OK" : "NG";

exit;
use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
