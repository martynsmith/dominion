package Dominion::Cards::Moneylender;

use Moose;
extends 'Dominion::Card';

has '+name'      => default => 'Moneylender';
has '+type'      => default => 'Action';
has '+set'       => default => 'Dominion';
has '+cost_gold' => default => 4;

# Trash a Copper from your hand.
# If you do, +3 Gold.

#__PACKAGE__->meta->make_immutable;
1;
