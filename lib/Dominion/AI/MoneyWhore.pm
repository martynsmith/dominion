package Dominion::AI::MoneyWhore;

use 5.010;
use Moose;
use List::Util qw(shuffle);

extends 'Dominion::AI';

has 'buycount'    => ( is => 'rw', isa => 'Int', default => 0 );
has 'moneylender' => ( is => 'rw', isa => 'Bool', default => 0 );

sub action {
    my ($self, $player, $state) = @_;

    my $card = ($player->hand->cards_of_type('action'))[0];

    $player->play($card->name);
}

sub buy {
    my ($self, $player, $state) = @_;

    $self->buycount($self->buycount+1);

    my $game = $player->game;

    my $coin = $player->coin;
    my $card;

    my @list;
    given ( $coin ) {
        when ( 0 ) { return $player->cleanup_phase(); }
        when ( 1 ) { return $player->cleanup_phase(); }
        when ( 2 ) { return $player->cleanup_phase(); }
        when ( 3 ) {
            @list = qw(Silver);
        }
        when ( 4 ) {
            if ( $self->moneylender ) {
                @list = qw(Silver);
                push @list, 'Gardens' if $self->buycount > 10;
            }
            else {
                @list = qw(MoneyLender);
                $self->moneylender(1);
            }
        }
        when ( 5 ) { return $player->cleanup_phase(); }
        when ( 6 ) {
            @list = qw(Gold);
        }
        when ( 7 ) { return $player->cleanup_phase(); }
    }
    if ( @list ) {
        foreach my $potential ( @list ) {
            ($card) //= $game->supply->card_by_name($potential);
        }
    }

    $card //= do {
        while ( $coin >= 0 ) {
            my @cards = grep { $_->cost_coin == $coin } $game->supply->cards;
            unless ( @cards ) {
                $coin--;
                next;
            }
            $card = @cards[int rand() * @cards];
            last;
        }
        $card;
    };

    $player->buy($card->name);
}

#__PACKAGE__->meta->make_immutable;
1;
