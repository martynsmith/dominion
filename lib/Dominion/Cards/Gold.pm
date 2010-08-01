package Dominion::Cards::Gold;

use Moose;
extends 'Dominion::Card';

has '+name' => default => 'Gold';
has '+type' => default => 'Treasure';
has '+set'  => default => 'Dominion';
has '+cost_coin' => default => 6;

sub coin { 3 };

#__PACKAGE__->meta->make_immutable;
1;

