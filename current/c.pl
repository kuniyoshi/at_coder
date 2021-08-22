#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $line = <> );
my( $s, $k ) = split m{\s}, $line;

my @chars = sort split m{}, $s;

my @words = ( ( join q{}, @chars ), recursive( @chars ) );
warn Dumper \@words;

#my $previous = q{};
#@words = grep { my $r = $_ ne $previous; $previous = $_; $r } sort @words;

say $words[ $k - 1 ];

exit;

sub recursive {
    my @chars = @_;
    return ( $chars[0] )
        if @chars == 1;
    return ( "$chars[0]$chars[1]", "$chars[1]$chars[0]" )
        if @chars == 2;
    return (
        $chars[0] . recursive( @chars[ 1 .. $#chars ] ),
        recursive( @chars[ 1 .. $#chars ] ) . $chars[0],
    );
}
