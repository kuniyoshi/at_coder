#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

#chomp( my $q = <> );
#my @queries = map { chomp; [ split m{\s} ] }
#              map { scalar <> }
#              1 .. $q;
#
#for my $query_ref ( @queries ) {
#}

my $t = BinaryTrieTree->new;

$t->insert( 3 );
$t->insert( 1 );
$t->insert( 4 );
$t->insert( 5 );

say $t->dump;
#
#say $t->count_lte( 2 );
#say $t->at( 2 );


exit;

package BinaryTrieTree;

sub BIT_SIZE { 3 }

sub BIT_SIZE_M1 { 2 }

sub new {
    return bless { zero => [undef], one => [undef], count => [0] }, shift;
}

sub dump {
    my $self = shift;
    my $zero = join q{, }, map { defined ? $_ : q{_} } @{ $self->{zero} };
    my $one = join q{, }, map { defined ? $_ : q{_} } @{ $self->{one} };
    my $count = join q{, }, map { defined ? $_ : q{_} } @{ $self->{count} };
    return sprintf <<'END_FORMAT', $zero, $one, $count;
zero:	[%s]
one:	[%s]
count:	[%s]
END_FORMAT
}

sub get_next {
    my $self = shift;
    my $index = shift;
    my $bit = shift;

    my( $zero_ref, $one_ref, $count_ref ) = @{ $self }{ qw( zero one count ) };

    die "no next of: [$index]"
        if $index >= @{ $zero_ref };

    if ( $bit == 0 ) {
        if ( !defined $zero_ref->[ $index ] ) {
            push @{ $zero_ref }, undef;
            push @{ $one_ref }, undef;
            push @{ $count_ref }, 0;
            $zero_ref->[ $index ] = $#{ $zero_ref };
            return $#{ $zero_ref };
        }
        return $zero_ref->[ $index ];
    }

    if ( $bit == 1 ) {
        if ( !defined $one_ref->[ $index ] ) {
            push @{ $zero_ref }, undef;
            push @{ $one_ref }, undef;
            push @{ $count_ref }, 0;
            $one_ref->[ $index ] = $#{ $one_ref };
            return $#{ $one_ref };
        }
        return $one_ref->[ $index ];
    }

    die "could not get next of: [$index], [$bit]";
}

sub insert {
    my $self = shift;
    my $value = shift;
warn "### insert $value";

    my( $zero_ref, $one_ref, $count_ref ) = @{ $self }{ qw( zero one count ) };

    $count_ref->[0]++;
    my $index = 0;

    for ( my $mask = 1 << BIT_SIZE_M1; $mask; $mask >>= 1 ) {
        my $bit = ( $value & $mask ) ? 1 : 0;
        printf "### mask:\t%03b\n", $mask;
        printf "--- bit:\t%d\n", $bit;
my $p = $index;
        $index = $self->get_next( $index, $bit );
        die "could not get next [$p], [$bit]\n", $self->dump
            unless defined $index;
        $count_ref->[ $index ]++;
    }
}

sub count_lte {
    my $self = shift;
    my $value = shift;
}

sub at {
    my $self = shift;
    my $kth = shift;
}
