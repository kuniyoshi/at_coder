#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my @s = do { chomp( my $l = <> ); split m{}, $l };
my @t = do { chomp( my $l = <> ); split m{}, $l };

if ( @s > @t ) {
    say YesNo::get( 0 );
    exit;
}

while ( @s ) {
    last
        if $t[0] ne $s[0];
    shift @s;
    shift @t;
}

say YesNo::get( !@s );


exit;

use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
