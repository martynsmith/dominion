package Dominion::Cards::Chapel;

use Moose;
extends 'Dominion::Card';

sub name        { 'Chapel' }
sub tags        { qw(kingdom action) }
sub box         { 'Dominion' }
sub cost_coin   { 2 }
sub cost_potion { 0 }

# Trash up to 4 cards from your hand.

#__PACKAGE__->meta->make_immutable;
1;
