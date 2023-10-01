#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $m, $n ) = do { chomp( my $l = <> ); split m{\s}, $l };
chomp( my $s = <> );
chomp( my $t = <> );

my $is_prefix = $t =~ m{\A $s }msx;
my $is_suffix = $t =~ m{ $s \z}msx;

if ( $is_prefix && $is_suffix ) {
    say 0;
}
elsif ( $is_prefix ) {
    say 1;
}
elsif ( $is_suffix ) {
    say 2;
}
else {
    say 3;
}

exit;
