package Dominion::Cards::Workshop;

use Moose;
extends 'Dominion::Card';

has '+name'      => default => 'Workshop';
has '+type'      => default => 'Action';
has '+set'       => default => 'Dominion';
has '+cost_gold' => default => 3;

# Gain a card costing up to 4

#__PACKAGE__->meta->make_immutable;
1;
