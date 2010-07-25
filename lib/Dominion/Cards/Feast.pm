package Dominion::Cards::Feast;

use Moose;
extends 'Dominion::Card';

has '+name'      => default => 'Feast';
has '+type'      => default => 'Action';
has '+set'       => default => 'Dominion';
has '+cost_gold' => default => 4;

# Trash this card. Gain a card costing up to 5 Gold.

#__PACKAGE__->meta->make_immutable;
1;
