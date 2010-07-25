package Dominion::Cards::Silver;

use Moose;
extends 'Dominion::Card';

has '+name' => default => 'Silver';
has '+type' => default => 'Treasure';
has '+set'  => default => 'Dominion';
has '+cost_gold' => default => 3;

#__PACKAGE__->meta->make_immutable;
1;
