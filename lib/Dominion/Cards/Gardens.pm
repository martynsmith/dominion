package Dominion::Cards::Gardens;

use Moose;
extends 'Dominion::Card';

has '+name'      => default => 'Gardens';
has '+type'      => default => 'Victory';
has '+set'       => default => 'Dominion';
has '+cost_gold' => default => 4;

# Worth 1 Victory for every 10 cards in your deck (rounded down).

#__PACKAGE__->meta->make_immutable;
1;
