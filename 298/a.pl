#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @s = do { chomp( my $l = <> ); split m{}, $l };

my $good = grep { $_ eq q{o} } @s;
my $bad = grep { $_ eq q{x} } @s;

say YesNo::get( !$bad && $good );

exit;
use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
