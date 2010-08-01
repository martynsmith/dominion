package Dominion::Cards::Woodcutter;

use Moose;
extends 'Dominion::Card';

sub name        { 'Woodcutter' }
sub tags        { qw(kingdom action) }
sub box         { 'Dominion' }
sub cost_coin   { 3 }
sub cost_potion { 0 }

sub action {
    my ($self, $player) = @_;

    # +1 buy
    $player->buys_add(1);

    # +2 coin
    $player->coin_add(2);
}

#__PACKAGE__->meta->make_immutable;
1;
