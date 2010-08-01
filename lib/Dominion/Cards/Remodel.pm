package Dominion::Cards::Remodel;

use Moose;
extends 'Dominion::Card';

sub name        { 'Remodel' }
sub tags        { qw(kingdom action) }
sub box         { 'Dominion' }
sub cost_coin   { 4 }
sub cost_potion { 0 }

# Trash a card from your hand. Gain a card costing up to 2 more than the trashed card.

#__PACKAGE__->meta->make_immutable;
1;
