package Dominion::Cards::Estate;

use Moose;
extends 'Dominion::Card';

has '+name' => default => 'Estate';
has '+type' => default => 'Victory';
has '+set'  => default => 'Dominion';
has '+cost_coin' => default => 2;

#__PACKAGE__->meta->make_immutable;
1;
