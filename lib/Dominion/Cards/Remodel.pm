package Dominion::Cards::Remodel;

use Moose;
extends 'Dominion::Card';

has '+name'      => default => 'Remodel';
has '+type'      => default => 'Action';
has '+set'       => default => 'Dominion';
has '+cost_coin' => default => 4;

# Trash a card from your hand. Gain a card costing up to 2 more than the trashed card.

#__PACKAGE__->meta->make_immutable;
1;
