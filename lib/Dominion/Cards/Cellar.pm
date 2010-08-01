package Dominion::Cards::Cellar;

use Moose;
extends 'Dominion::Card';

sub name        { 'Cellar' }
sub tags        { qw(kingdom action) }
sub box         { 'Dominion' }
sub cost_coin   { 2 }
sub cost_potion { 0 }

# +1 Action
# Discard any number of cards. +1 Card per card discarded

#__PACKAGE__->meta->make_immutable;
1;
