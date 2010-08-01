package Dominion::Cards::CouncilRoom;

use Moose;
extends 'Dominion::Card';

sub name        { 'Council Room' }
sub tags        { qw(kingdom action) }
sub box         { 'Dominion' }
sub cost_coin   { 5 }
sub cost_potion { 0 }

sub action {
    my ($self, $player) = @_;

    # +4 cards
    $player->hand->add($player->draw(4));

    # +1 buy
    $player->buys_add(1);

    # Each other player draws a card.
    foreach my $other_player ( $player->other_players ) {
        $other_player->hand->add($other_player->draw(1));
    }
}

#__PACKAGE__->meta->make_immutable;
1;
