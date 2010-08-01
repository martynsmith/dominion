package Dominion::Cards::Chapel;

use Moose;
extends 'Dominion::Card';

has '+name'      => default => 'Chapel';
has '+type'      => default => 'Action';
has '+set'       => default => 'Dominion';
has '+cost_coin' => default => 2;

# Trash up to 4 cards from your hand.

#__PACKAGE__->meta->make_immutable;
1;
