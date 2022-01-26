#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $n = <> );
my @a = map { chomp; [ split m{\s} ] }
        map { scalar <> }
        1 .. ( 2 * $n - 1 );

say dfs( [ ], [ 0 .. ( 2 * $n - 1 ) ], { }, 0 );

exit;

sub dfs {
    my $selectins_ref = shift;
    my $buffer_ref = shift;
    my $paired_ref = shift;
    my $max = shift;

    #    warn sprintf "### selection: [%s]", join q{, }, @{ $selectins_ref };
    #    warn sprintf "### buffer: [%s]", join q{, }, @{ $buffer_ref };

    unless ( @{ $buffer_ref } ) {
        die "somehow"
            unless @{ $selectins_ref } == ( 2 * $n );

            #say sprintf "### selection: [%s]", join q{, }, @{ $selectins_ref };

        my $candidate = 0;

        for ( my $i = 0; $i < $n; ++$i ) {
            my $u = 2 * $i;
            my $v = 2 * $i + 1;
            #            warn "(\$u, \$v): ($u, $v)";
            die "should be ascend"
                unless $selectins_ref->[ $u ] < $selectins_ref->[ $v ];
            my( $w, $x ) = @{ $selectins_ref }[ $u, $v ];
            die "out of range ($w, $x)"
                if $w >= @a || ( $x - $w - 1 ) >= @{ $a[ $w ] };
                #warn "value: $a[ $w ][ $x - $w - 1 ]";
            $candidate = $candidate ^ $a[ $w ][ $x - $w - 1 ];
        }

        return $candidate > $max ? $candidate : $max;
    }

    die sprintf "buffer should be multiple 2: [%s]", join q{, }, @{ $buffer_ref }
        if @{ $buffer_ref } % 2;

    my $candidate = $max;

    for ( my $i = 0; $i < @{ $buffer_ref }; ++$i ) {
        for ( my $j = 0; $j < $i; ++$j ) {
            #        warn "(\$i, \$j): ($i, $j)";
            next
                if $j == $i;# or $paired_ref->{ 10 * $j + $i }++;
                #                if $j == $i or $paired_ref->{ 10 * $j + $i }++;
            my @c = ( @{ $selectins_ref }, @{ $buffer_ref }[ $j, $i ] );
            $candidate = dfs( \@c, [ @{ $buffer_ref }[ 0 .. ( $j - 1 ), ( $j + 1 ) .. ( $i - 1 ), ( $i + 1 ) .. $#{ $buffer_ref } ] ], $paired_ref, $candidate );
        }
    }

    return $candidate > $max ? $candidate : $max;
}
