package Dominion::Cards::Moneylender;

use Moose;
extends 'Dominion::Card';

sub name        { 'Moneylender' }
sub tags        { qw(kingdom action) }
sub box         { 'Dominion' }
sub cost_coin   { 4 }
sub cost_potion { 0 }

sub action {
    my ($self, $player, $game) = @_;

    # Trash a Copper from your hand.
    # If you do, +3 Gold.

    my $copper = $player->hand->card_by_name('Copper');

    if ( $copper ) {
        $game->trash->add($copper);
        $player->coin_add(3);
    }
}

#__PACKAGE__->meta->make_immutable;
1;
