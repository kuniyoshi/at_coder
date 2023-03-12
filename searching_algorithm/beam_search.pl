#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use List::Util qw( min );

my $s = State->new( height => 3, width => 4, seed => 42, turn_limit => 4 );
$s->dump;

#say random( $s, 92, 1000 ); # 12.754
#say beam_search( $s, 92, 1000, 4, 100 ); # 23

exit;

sub beam_search {
    my $base = shift;
    my $seed = shift;
    my $playout = shift;
    my $beam_depth = shift;
    my $beam_width = shift;
    srand $seed;

    my $total = 0;

    for my $i ( 0 .. $playout - 1 ) {
        my @beams = ( $base->clone );

        for my $j ( 0 .. $beam_depth - 1 ) {
            my @next_beams;

            for my $beam ( @beams ) {
                push @next_beams, map {
                    my $state = $beam->clone;
                    $state->advance( $_ );
                    $state
                } $beam->valid_actions;
            }

            @beams = sort { $b->score <=> $a->score } @next_beams;
            $#beams = min( $#beams, $beam_width - 1 );
        }

        $total += $beams[0]->score;
    }

    return $total / $playout;
}

sub random {
    my $base = shift;
    my $seed = shift;
    my $playout = shift;
    srand $seed;

    my $total = 0;

    for my $i ( 0 .. $playout - 1 ) {
        my $state = $base->clone;
        until ( $state->is_done ) {
            my @actions = $state->valid_actions;
            $state->advance( $actions[ rand @actions ] );
            #            $state->dump;
        }
        $total += $state->score;
    }

    return $total / $playout;
}

package State {
    use Data::Dumper;

    sub is_done {
        my $self = shift;
        return $self->{turn_passed} == $self->{turn_limit};
    }

    sub score {
        my $self = shift;
        return $self->{score};
    }

    sub new {
        my $class = shift;
        my %parameter = @_;
        srand $parameter{seed};
        my @board = map { [ map { int( rand 9 ) } 1 .. $parameter{width} ] } 1 .. $parameter{height};
        my $character = int( rand $parameter{height} * $parameter{width} );
        my @coord = ( int( $character / $parameter{height} ), $character % $parameter{height} );
        $board[ $coord[0] ][ $coord[1] ] = 0;
        return bless {
            board => \@board,
            character => \@coord,
            turn_limit => $parameter{turn_limit},
            score => 0,
            turn_passed => 0,
        }, $class;
    }

    sub clone {
        my $self = shift;
        my %copy = %{ $self };
        $copy{board} = [ @{ $copy{board} } ];
        $copy{board}[ $_ ] = [ @{ $self->{board}[ $_ ] } ]
            for 0 .. $self->height - 1;
        return bless \%copy, ref $self;
    }

    sub advance {
        my $self = shift;
        my $action_ref = shift;
        die "already done"
            if $self->is_done;
        my @coord = ( $self->{character}[0] + $action_ref->[0], $self->{character}[1] + $action_ref->[1] );
        die "invalid action"
            if $coord[0] < 0 || $coord[0] >= $self->height || $coord[1] < 0 || $coord[1] >= $self->width;
        $self->{character} = \@coord;
        $self->{score} += $self->{board}[ $coord[0] ][ $coord[1] ];
        $self->{board}[ $coord[0] ][ $coord[1] ] = 0;
        $self->{turn_passed}++;
    }

    sub height {
        my $self = shift;
        return scalar @{ $self->{board} };
    }

    sub width {
        my $self = shift;
        return scalar @{ $self->{board}[0] };
    }

    sub dump {
        my $self = shift;
        say $self->board_status;
        say "score: $self->{score}";
        say "turn: $self->{turn_passed}/$self->{turn_limit}";
        say q{};
    }

    sub board_status {
        my $self = shift;
        my @coord = @{ $self->{character} };
        my $board = $self->{board};
        my @lines;
        for my $i ( 0 .. $self->height - 1 ) {
            my @chars;
            for my $j ( 0 .. $self->width - 1 ) {
                push @chars, ( $i == $coord[0] && $j == $coord[1] )
                    ? q{@}
                    : $board->[ $i ][ $j ]
                    ? $board->[ $i ][ $j ]
                    : q{.};
            }
            push @lines, join q{}, @chars;
        }
        return join qq{\n}, @lines;
    }

    sub valid_actions {
        my $self = shift;
        my( $i, $j ) = @{ $self->{character} };
        my $height = $self->height;
        my $width = $self->width;
        return grep { $i + $_->[0] >= 0 && $i + $_->[0] < $height && $j + $_->[1] >= 0 && $j + $_->[1] < $width }
               _moves( );
    }

    sub _moves {
        return( [ -1, 0 ], [ 0, -1 ], [ 0, 1 ], [ 1, 0 ] );
    }
}
