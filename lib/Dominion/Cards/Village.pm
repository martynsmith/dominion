package Dominion::Cards::Village;

use Moose;
extends 'Dominion::Card';

sub name        { 'Village' }
sub tags        { qw(kingdom action) }
sub box         { 'Dominion' }
sub cost_coin   { 3 }
sub cost_potion { 0 }

sub action {
    my ($self, $player) = @_;

    # +1 Card
    $player->hand->add($player->draw(1));

    # +2 Actions
    $player->actions_add(2);
}

#__PACKAGE__->meta->make_immutable;
1;
