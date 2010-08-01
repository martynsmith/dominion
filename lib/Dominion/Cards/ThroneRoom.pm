package Dominion::Cards::ThroneRoom;

use Moose;
extends 'Dominion::Card';

sub name        { 'Throne Room' }
sub tags        { qw(kingdom action) }
sub box         { 'Dominion' }
sub cost_coin   { 4 }
sub cost_potion { 0 }

# Choose an Action card in your hand.
# Play it twice.

#__PACKAGE__->meta->make_immutable;
1;
