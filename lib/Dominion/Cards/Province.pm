package Dominion::Cards::Province;

use Moose;
extends 'Dominion::Card';

has '+name' => default => 'Province';
has '+type' => default => 'Victory';
has '+set'  => default => 'Dominion';
has '+cost_gold' => default => 8;

#__PACKAGE__->meta->make_immutable;
1;
