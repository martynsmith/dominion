package Dominion::AI::HalfRetard;

use 5.010;
use Moose;
use List::Util qw(shuffle);

extends 'Dominion::AI';

has 'buycount' => ( is => 'rw', isa => 'Int', default => 0 );

sub action {
    my ($self, $player, $state) = @_;

    my $card;

    $card //= ($player->hand->grep(sub { $_->name eq 'Market' }))[0];
    $card //= ($player->hand->grep(sub { $_->name eq 'Village' }))[0];
    $card //= ($player->hand->grep(sub { $_->name eq 'Festival' }))[0];

    # Fallback
    $card //= ($player->hand->cards_of_type('action'))[0];

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
        when ( 2 ) {
            @list = qw(Moat);
        }
        when ( 3 ) {
            @list = qw(Village Silver);
        }
        when ( 4 ) {
            @list = qw(Smithy);
            push @list, 'Gardens' if $self->buycount > 10;
        }
        when ( 5 ) {
            @list = shuffle(qw(Witch Laboratory Market Festival));
            push @list, 'Duchy' if $self->buycount > 10;
        }
        when ( 6 ) {
            @list = qw(Gold);
        }
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

sub attack {
    my ($self, $player, $state, $attack) = @_;

    return $attack->done if $attack->cancelled;

    return $attack->play('Moat') if $player->hand->card_by_name('Moat');

    return $attack->done;
}

#__PACKAGE__->meta->make_immutable;
1;
