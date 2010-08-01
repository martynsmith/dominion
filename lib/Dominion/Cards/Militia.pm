package Dominion::Cards::Militia;

use Moose;
extends 'Dominion::Card';

sub name        { 'Militia' }
sub tags        { qw(kingdom action) }
sub box         { 'Dominion' }
sub cost_coin   { 4 }
sub cost_potion { 0 }

# Attack
# +2 Gold
# Each other player discards down to 3 cards in his hand.

#__PACKAGE__->meta->make_immutable;
1;
