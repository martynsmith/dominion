package Dominion::Cards::Moneylender;

use Moose;
extends 'Dominion::Card';

sub name        { 'Moneylender' }
sub tags        { qw(kingdom action) }
sub box         { 'Dominion' }
sub cost_coin   { 4 }
sub cost_potion { 0 }

# Trash a Copper from your hand.
# If you do, +3 Gold.

#__PACKAGE__->meta->make_immutable;
1;
