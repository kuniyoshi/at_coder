#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

my( $h, $w, $n ) = split m{\s}, <>;
chomp( my @cards = <> );

my $r_btree = [ undef, undef, undef ];
my $c_btree = [ undef, undef, undef ];

for my $card ( @cards ) {
    my( $r, $c ) = split m{\s}, $card;

    build_btree( $r_btree, $r );
    build_btree( $c_btree, $c );
}

my $rows_ref = extract_btree( $r_btree );

for my $card ( @cards ) {
    my( $r, $c ) = split m{\s}, $card;
}


exit;

sub build_btree {
    my $node = shift;
    my $value = shift;

    while ( 1 ) {
        my( $top, $left, $right, undef ) = @{ $node };
        if ( !defined $top ) {
            $top = [ $value, undef, undef, $node ];
            $node->[0] = $top;
            last;
        }
        if ( $top < $value ) {
            if ( !defined $right ) {
                $right = [ $value, undef, undef, $node ];
                $node->[2] = $right;
                last;
            }
            $node = $right;
            next;
        }
        if ( $top > $value ) {
            if ( !defined $left ) {
                $left = [ $value, undef, undef, $node ];
                $node->[1] = $left;
                last;
            }
            $node = $left;
            next;
        }
    }
}

for my $card_index ( 0 .. $#cards ) {
    my $card = $cards[ $card_index ];
    my( $r_number, $c_number ) = split m{\s}, $card;
    $row{ $r_number }++;
    $col{ $c_number }++;
}

my @rows = sort { $a <=> $b } keys %row;
my @cols = sort { $a <=> $b } keys %col;

%row = ( );
%col = ( );

for my $card ( @cards ) {
    my( $r, $c ) = split m{\s}, $card;

    my $r_count = 0;

    for my $row ( @rows ) {
        last
            if $row > $r;
        $r_count++;
    }

    my $c_count = 0;

    for my $col ( @cols ) {
        last
            if $col > $c;
        $c_count++;
    }

    say "$r_count $c_count";
}


exit;

__END__
for my $card ( @cards ) {
    my( $r, $c ) = split m{\s}, $card;
    my $skips = 0;

    my $r_index = $r - scalar grep { !$row{ $_ } } ( 1 .. $r );
    my $c_index = $c - scalar grep { !$col{ $_ } } ( 1 .. $c );

    say "$r_index $c_index";
}

exit;

