package Dominion::Cards::Laboratory;

use Moose;
extends 'Dominion::Card';

sub name        { 'Laboratory' }
sub tags        { qw(kingdom action) }
sub box         { 'Dominion' }
sub cost_coin   { 5 }
sub cost_potion { 0 }

sub action {
    my ($self, $player) = @_;

    # +2 card
    $player->hand->add($player->draw(2));

    # +1 action
    $player->actions_add(1);
}

#__PACKAGE__->meta->make_immutable;
1;
