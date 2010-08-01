package Dominion::Cards::Mine;

use Moose;
extends 'Dominion::Card';

sub name        { 'Mine' }
sub tags        { qw(kingdom action) }
sub box         { 'Dominion' }
sub cost_coin   { 5 }
sub cost_potion { 0 }

# Trash a Trasure card from your hand. Gain a Treasure card costing up to 3
# more; put it into your hand.

#__PACKAGE__->meta->make_immutable;
1;
