package Dominion::Cards::Chancellor;

use Moose;
extends 'Dominion::Card';

sub name        { 'Chancellor' }
sub tags        { qw(kingdom action) }
sub box         { 'Dominion' }
sub cost_coin   { 3 }
sub cost_potion { 0 }

sub action {
    my ($self, $player, $game) = @_;

    # +2 coin
    $player->coin_add(2);

    # You may immediately put your deck into your discard pile.
    $game->interaction_add(Dominion::Interaction::Question->new(
        player   => $player,
        card     => $self,
        message => 'You can now optionally put your deck into your discard pile',
        options => {
            0 => 'Do NOT discard your deck',
            1 => 'DO discard your deck',
        },
        callback => sub {
            my ($self) = @_;

            if ( $self->answer == 1 ) {
                $player->discard->add($player->deck->cards);
            }
        }
    ));
}

#__PACKAGE__->meta->make_immutable;
1;
