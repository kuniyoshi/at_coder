#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
chomp( my $s = <> );
my @s = split m{}, $s;

my @closes;
my @opens;

for my $i ( 0 .. $#s ) {
    if ( $s[ $i ] eq q{(} ) {
        push @opens, $i;
    }
    if ( $s[ $i ] eq q{)} ) {
        push @closes, $i;
    }
}

my @is_use = ( 1 ) x $n;

for my $i ( 0 .. $#closes ) {
    
}


__END__
while ( $s && $s =~ s{([(][^()]*[)])+}{}g ) {
    ;
}

say $s || q{};

exit;
