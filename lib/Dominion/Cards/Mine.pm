package Dominion::Cards::Mine;

use Moose;
extends 'Dominion::Card';

has '+name'      => default => 'Mine';
has '+type'      => default => 'Action';
has '+set'       => default => 'Dominion';
has '+cost_gold' => default => 5;

# Trash a Trasure card from your hand. Gain a Treasure card costing up to 3
# more; put it into your hand.

#__PACKAGE__->meta->make_immutable;
1;
