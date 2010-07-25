package Dominion::Cards::Copper;

use Moose;
extends 'Dominion::Card';

has '+name'      => default => 'Copper';
has '+type'      => default => 'Treasure';
has '+set'       => default => 'Dominion';
has '+cost_gold' => default => 0;

#__PACKAGE__->meta->make_immutable;
1;
