#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;

chomp( my $line = <> );
my( $s, $k ) = split m{\s}, $line;

my $worker = OrderPattern->new( $s );
$worker->list;

my $previous = q{};
my @words = grep { my $is_same = $_ ne $previous; $previous = $_; $is_same }
            sort @{ $worker->{result} };

say $words[ $k - 1 ];

exit;

package OrderPattern;

sub new {
    my $class = shift;
    my $string = shift;

    return bless { string => [ split m{}, $string ] }, $class;
}

sub result {
    my $self = shift;
    return $self->{result};
}

sub list {
    my $self = shift;
    $self->{chars} = [ ];
    $self->{size} = @{ $self->{string} };
    $self->{result} = [ ];
    return $self->retrieve_all_patterns( ( 1 << $self->{size} ) - 1 );
}

sub retrieve_all_patterns {
    my $self = shift;
    my $usable_bitmap = shift;

    if ( $usable_bitmap == 0 ) {
        push @{ $self->{result} }, join q{}, @{ $self->{chars} };
        return;
    }

    for my $i ( 0 .. ( $self->{size} - 1 ) ) {
        if ( $usable_bitmap & ( 1 << $i ) ) {
            push @{ $self->{chars} }, $self->{string}[ $i ];
            $self->retrieve_all_patterns( $usable_bitmap ^ ( 1 << $i ) );
            pop @{ $self->{chars} };
        }
    }
}
