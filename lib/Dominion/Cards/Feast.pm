package Dominion::Cards::Feast;

use Moose;
extends 'Dominion::Card';

sub name        { 'Feast' }
sub tags        { qw(kingdom action) }
sub box         { 'Dominion' }
sub cost_coin   { 4 }
sub cost_potion { 0 }

# Trash this card. Gain a card costing up to 5 Gold.

#__PACKAGE__->meta->make_immutable;
1;
