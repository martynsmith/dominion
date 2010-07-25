package Dominion::Cards::ThroneRoom;

use Moose;
extends 'Dominion::Card';

has '+name'      => default => 'Throne Room';
has '+type'      => default => 'Action';
has '+set'       => default => 'Dominion';
has '+cost_gold' => default => 4;

# Choose an Action card in your hand.
# Play it twice.

#__PACKAGE__->meta->make_immutable;
1;
