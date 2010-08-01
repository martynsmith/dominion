package Dominion::Cards::CouncilRoom;

use Moose;
extends 'Dominion::Card';

sub name        { 'Council Room' }
sub tags        { qw(kingdom action) }
sub box         { 'Dominion' }
sub cost_coin   { 5 }
sub cost_potion { 0 }

# +4 Cards
# +1 Buy
# Each other player draws a card.

#__PACKAGE__->meta->make_immutable;
1;
