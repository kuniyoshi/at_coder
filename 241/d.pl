#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Time::HiRes qw( gettimeofday tv_interval );

chomp( my $q = <> );
#my @queries = map { chomp; [ split m{\s} ] }
#              map { scalar <> }
#              1 .. $q;

my @counts = ( 0 ) x 4 * 10 ** 5;
my @zeros;
$#zeros = 4 * 10 ** 5;
my @ones;
$#ones = 4 * 10 ** 5;

my $c_index = 1;

my $lte_time = 0;
my $at_time = 0;
my $insert_time = 0;
my $start;
my $index;

for my $query_count ( 1 .. $q ) {
    chomp( my $line = <> );
    my( $op_code, $x, $k ) = split m{\s}, $line;

    if ( $op_code == 1 ) {
        $counts[0]++;
        $index = 0;

        for ( my $mask = 1 << 59; $mask; $mask >>= 1 ) {
            $index = ( $x & $mask )
                ? ( $ones[ $index ] //= $c_index++ )
                : ( $zeros[ $index ] //= $c_index++ );
            $counts[ $index ]++;
        }
    }

    if ( $op_code == 2 ) {
        $index = 0;
        my $count = $counts[0];

        for ( my $mask = 1 << 59; $mask; $mask >>= 1 ) {
            my $bit = ( $x & $mask );

            if ( $bit == 0 && defined $ones[ $index ] ) {
                $count -= $counts[ $ones[ $index ] ];
            }

            $index = $bit == 0 ? $zeros[ $index ] : $ones[ $index ];

            last
                unless defined $index;
        }

        my $kth = $count - $k + 1;

        if ( $kth <= 0 || $kth > $counts[0] ) {
            say -1;
            next;
        }

        my $remain = $kth;
        $index = 0;
        my $result = 0;

        for ( my $mask = 1 << 59; $mask; $mask >>= 1 ) {
            my $less = defined $zeros[ $index ] ? $counts[ $zeros[ $index ] ] : 0;
            my $more = defined $ones[ $index ] ? $counts[ $ones[ $index ] ] : 0;

            if ( $remain <= $less ) {
                $index = $zeros[ $index ];
                next;
            }

            $remain -= $less;
            $index = $ones[ $index ];
            $result |= $mask;
        }

        say $result;
    }

    if ( $op_code == 3 ) {
        $index = 0;
        my $count = $counts[0];

        for ( my $mask = 1 << 59; $mask; $mask >>= 1 ) {
            my $bit = ( $x & $mask );

            if ( $bit == 0 && defined $ones[ $index ] ) {
                $count -= $counts[ $ones[ $index ] ];
            }

            $index = $bit == 0 ? $zeros[ $index ] : $ones[ $index ];

            last
                unless defined $index;
        }

        if ( ( $count + $k ) <= 0 || ( $count + $k ) > $counts[0] ) {
            say -1;
            next;
        }

        my $remain = $count + $k;
        $index = 0;
        my $result = 0;

        for ( my $mask = 1 << 59; $mask; $mask >>= 1 ) {
            my $less = defined $zeros[ $index ] ? $counts[ $zeros[ $index ] ] : 0;
            my $more = defined $ones[ $index ] ? $counts[ $ones[ $index ] ] : 0;

            if ( $remain <= $less ) {
                $index = $zeros[ $index ];
                next;
            }

            $remain -= $less;
            $index = $ones[ $index ];
            $result |= $mask;
        }

        say $result;
    }
}

#warn "\$insert_time: $insert_time";
#warn "\$lte_time: $lte_time";
#warn "\$at_time: $at_time";

#$t->insert( 3 );
#$t->insert( 1 );
#$t->insert( 4 );
#$t->insert( 5 );
#
#say $t->dump;
#
#for my $i ( 0 .. 6 ) {
#    say "count lte: $i = ", $t->count_lte( $i );
#}
#
#for my $i ( 0 .. 6 ) {
#    say "at: $i = ", $t->at( $i ) // -1;
#}


exit;

package BinaryTrieTree;

sub BIT_SIZE { 60 }

sub BIT_SIZE_M1 { 59 }

sub new {
    my @z;
    $#z = 2 * 10 ** 5;
    my @o;
    $#o = 2 * 10 ** 5;
    #    return bless { zero => [(undef) x 2*10**5], one => [(undef) x 2*10**5], count => [(0) x 2*10**5] }, shift;
    return bless { zero => \@z, one => \@o, count => [(0) x 2*10**5] }, shift;
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

sub size {
    my $self = shift;
    return $self->{count}[0];
}

sub get_next {
    my $self = shift;
    my $index = shift;
    my $bit = shift;
    my $readonly = shift;

    my( $zero_ref, $one_ref, $count_ref ) = @{ $self }{ qw( zero one count ) };

    die "no next of: [$index]"
        if $index >= @{ $zero_ref };

    if ( $bit == 0 ) {
        return
            if $readonly && !defined $zero_ref->[ $index ];

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
        return
            if $readonly && !defined $one_ref->[ $index ];

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

    $self->{count}[0]++;
    my $index = 0;
    my( $zero_ref, $one_ref, $count_ref ) = @{ $self }{ qw( zero one count ) };

    for ( my $mask = 1 << 59; $mask; $mask >>= 1 ) {
        my $bit = ( $value & $mask ) ? 1 : 0;
    if ( $bit == 0 ) {
        if ( !defined $zero_ref->[ $index ] ) {
            push @{ $zero_ref }, undef;
            push @{ $one_ref }, undef;
            push @{ $count_ref }, 0;
            $zero_ref->[ $index ] = $#{ $zero_ref };
        }
        $index = $zero_ref->[ $index ];
    }
    if ( $bit == 1 ) {
        if ( !defined $one_ref->[ $index ] ) {
            push @{ $zero_ref }, undef;
            push @{ $one_ref }, undef;
            push @{ $count_ref }, 0;
            $one_ref->[ $index ] = $#{ $one_ref };
        }
        $index = $one_ref->[ $index ];
    }
    #        $index = $self->get_next( $index, $bit );
        $self->{count}[ $index ]++;
    }
}

sub count_lte {
    my $self = shift;
    my $value = shift;

    my( $zero_ref, $one_ref, $count_ref ) = @{ $self }{ qw( zero one count ) };

    my $index = 0;
    my $count = $count_ref->[0];

    for ( my $mask = 1 << 59; $mask; $mask >>= 1 ) {
        my $bit = ( $value & $mask ) ? 1 : 0;

        if ( $bit == 0 && defined $one_ref->[ $index ] ) {
            $count = $count - $count_ref->[ $one_ref->[ $index ] ];
        }

        $index = $bit == 0 ? $zero_ref->[ $index ] : $one_ref->[ $index ]; #$self->get_next( $index, $bit, 1 );

        return $count
            unless defined $index;
    }

    return $count;
}

sub at {
    my $self = shift;
    my $kth = shift;

    my( $zero_ref, $one_ref, $count_ref ) = @{ $self }{ qw( zero one count ) };

    return
        if $kth <= 0 || $kth > $count_ref->[0];

    my $remain = $kth;
    my $index = 0;
    my $result = 0;

    for ( my $mask = 1 << 59; $mask; $mask >>= 1 ) {
        #warn sprintf "### mask:\t%03b", $mask;
        #warn "--- \$index:\t$index";
        #warn "--- \$remain\t$remain";
        #warn "--- \$result\t$result";
        #        die "no more node here"
        #            if !defined $zero_ref->[ $index ] && !defined $one_ref->[ $index ];

        my $less = defined $zero_ref->[ $index ] ? $count_ref->[ $zero_ref->[ $index ] ] : 0;
        my $more = defined $one_ref->[ $index ] ? $count_ref->[ $one_ref->[ $index ] ] : 0;

        if ( $remain <= $less ) {
            #            die "no node to zero"
            #                unless defined $zero_ref->[ $index ];
            $remain = $remain;
            #warn "0: count goes: $remain";
            $index = $zero_ref->[ $index ];
            #            die "Could not get index"
            #                unless defined $index;
            next;
        }

        #        die "no node to one"
        #            unless defined $one_ref->[ $index ];

        $remain = $remain - $less;
        #warn "1: count goes: $remain";
        $index = $one_ref->[ $index ];
        #        die "Could not get index"
        #            unless defined $index;
        $result = $result | $mask;
    }

    return $result;
}
