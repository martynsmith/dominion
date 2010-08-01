package Dominion::Cards::Smithy;

use Moose;
extends 'Dominion::Card';

sub name      { 'Smithy' }
sub tags      { qw(kingdom action) }
sub box       { 'Dominion' }
sub cost_coin { 4 }

sub action {
    my ($self, $player) = @_;

    # +3 cards
    $player->hand->add($player->draw(3));
}

#__PACKAGE__->meta->make_immutable;
1;
