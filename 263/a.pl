#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $a, $b, $c, $d, $e ) = do { chomp( my $l = <> ); split m{\s}, $l };

my %count;
$count{ $a }++;
$count{ $b }++;
$count{ $c }++;
$count{ $d }++;
$count{ $e }++;

my $is = scalar( %count ) == 2 && !grep { $_ == 1 } values %count;

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
