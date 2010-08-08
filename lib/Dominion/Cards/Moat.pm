package Dominion::Cards::Moat;

use Moose;
extends 'Dominion::Card';

sub name        { 'Moat' }
sub tags        { qw(kingdom action reaction) }
sub box         { 'Dominion' }
sub cost_coin   { 2 }
sub cost_potion { 0 }

sub action {
    my ($self, $player, $game) = @_;

    # +2 Card
    $player->hand->add($player->draw(2));
}

sub reaction {
    my ($self, $player, $game, $attack) = @_;

    $attack->cancel();

    return 0;
}

#__PACKAGE__->meta->make_immutable;
1;
