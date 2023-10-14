#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = do { chomp( my $l = <> ); split m{\s}, $l };

my %count;
$count{ $_ }++
    for @a;

say YesNo::get( %count == 1 );

exit;
use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
