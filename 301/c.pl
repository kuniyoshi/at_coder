#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

my @s = do { chomp( my $l = <> ); split m{}, $l };
my @t = do { chomp( my $l = <> ); split m{}, $l };

my %s;
my %t;

$s{ $_ }++
    for @s;
$t{ $_ }++
    for @t;

for my $c ( "a" .. "z" ) {
    my $min = min( $s{ $c } // 0, $t{ $c } // 0 );
    $s{ $c } -= $min;
    $t{ $c } -= $min;
    delete $s{ $c }
        if $s{ $c } <= 0;
    delete $t{ $c }
        if $t{ $c } <= 0;
}

#warn Dumper \%s;
#warn Dumper \%t;

my @chars = split m{}, lc "AtCoder";

change( \%t, \%s );
change( \%s, \%t );

#warn Dumper \%s;
#warn Dumper \%t;

my $min = min( $s{ q{@} } // 0, $t{ q{@} } // 0 );
$s{ q{@} } -= $min;
delete $s{ q{@} }
    if $s{ q{@} } <= 0;
$t{ q{@} } -= $min;
delete $t{ q{@} }
    if $t{ q{@} } <= 0;

say YesNo::get( !%s && !%s );

exit;

sub change {
    my $from = shift;
    my $to = shift;
    my $used = _change( $to, $from->{ q{@} } // 0 );
    $from->{ q{@} } -= $used;
    delete $from->{ q{@} }
        if $from->{ q{@} } <= 0;
}

sub _change {
    my $set = shift;
    my $count = shift;
    my $used = 0;

    for ( my $i = 0; $i < $count; ++$i ) {
        for my $c ( @chars ) {
            next
                unless $set->{ $c };

            $set->{ $c }--;
            delete $set->{ $c }
                unless $set->{ $c };

            $used++;
        }
    }

    return $used;
}


use utf8;
use strict;
use warnings;

package YesNo;

sub get {
    return $_[-1] ? "Yes" : "No";
}

1;
