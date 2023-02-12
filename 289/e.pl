#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

for my $i ( 0 .. 2000 ) {
    for my $j ( 0 .. 2000 ) {
        for my $k ( 0 .. 2000 ) {
        }
    }
}

__END__

chomp( my $t = <> );

while ( $t-- ) {
    say solve( );
}

exit;

sub solve {
    my( $n, $m ) = do { chomp( my $l = <> ); split m{\s}, $l };
    my @c = do { chomp( my $l = <> ); split m{\s}, $l };
    my @edges = map { chomp; [ split m{\s} ] }
                map { scalar <> }
                1 .. $m;

    my %links;

    for my $ref ( @edges ) {
        my( $u, $v ) = @{ $ref };
        push @{ $links{ $u } }, $v;
        push @{ $links{ $v } }, $u;
    }


}
