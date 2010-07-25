package Dominion::Cards::Duchy;

use Moose;
extends 'Dominion::Card';

has '+name' => default => 'Duchy';
has '+type' => default => 'Victory';
has '+set'  => default => 'Dominion';
has '+cost_gold' => default => 5;

#__PACKAGE__->meta->make_immutable;
1;
