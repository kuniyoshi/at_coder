#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @s = map { chomp( my $l = <> ); $l }
        1 .. $n;

my %count;
$count{ $_ }++
    for @s;

say YesNo::get( ( $count{For} // 0 ) > ( $count{Against} // 0 ) );

exit;
use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
