#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Path::Class qw( file );
use List::Util qw( shuffle min );

chomp( my @files = `fd README.md` );
@files = grep { m{\A \d+/ }msx } @files;

my @candidates;

for my $file ( @files ) {
    my $contest = contest( $file );
    my @lines = file( $file )->slurp( iomode => "<:encoding(UTF-8)", chomp => 1 );
    for my $line ( @lines ) {
        if ( $line =~ m{\A [|] \s ([ABCDE]) \s+ .*? (\d+) \s+ min }msx ) {
            my( $problem, $minutes ) = ( $1, $2 );
            if ( $minutes > 30 ) {
                push @candidates, { contest => $contest, problem => $problem, minutes => $minutes };
            }
        }
    }
}

chomp( my @works = `fd . training/src/bin` );
my %done;

for my $work ( @works ) {
    if ( $work =~ m{/ t \d+ \.rs \z}msx ) {
        next;
    }

    if ( $work =~ m{/ (\d+) (\w) \.rs \z}msx ) {
        my $contest = $1;
        my $problem = uc $2;
        $done{ $contest }{ $problem }++;
        next;
    }

    die "Could not parse file: $work";
}

my @candiates = shuffle grep { !$done{ $_->{contest} }{ $_->{problem} } } @candidates;
$#candiates = min( 5, $#candiates );
say Data::Dumper->new( \@candiates )->Terse( 1 )->Sortkeys( 1 )->Dump( );

exit;

sub contest {
    my $file = shift;
    if ( $file =~ m{\A (\d+) / }msx ) {
        return $1;
    }
    die "Could not parse contest: [$file]";
}

__END__
| A    | -    | -                   |   min        |
| B    | -    | -                   |    min       |
| C    | -    | -                   |     min      |
| D    | -    | -                   |     min      |
| E    | -    | -                   |     min      |
| F    | -    | -                   |     min      |
