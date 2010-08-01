package Dominion::Cards::Market;

use Moose;
extends 'Dominion::Card';

sub name        { 'Market' }
sub tags        { qw(kingdom action) }
sub box         { 'Dominion' }
sub cost_coin   { 5 }
sub cost_potion { 0 }

sub action {
    my ($self, $player) = @_;

    # +1 card
    $player->hand->add($player->draw(1));

    # +1 action
    $player->actions_add(1);

    # +1 buy
    $player->buys_add(1);

    # +1 coin
    $player->coin_add(1);
}

#__PACKAGE__->meta->make_immutable;
1;
