package Dominion::Cards::Workshop;

use Moose;
extends 'Dominion::Card';

sub name        { 'Workshop' }
sub tags        { qw(kingdom action) }
sub box         { 'Dominion' }
sub cost_coin   { 3 }
sub cost_potion { 0 }

# Gain a card costing up to 4

#__PACKAGE__->meta->make_immutable;
1;
