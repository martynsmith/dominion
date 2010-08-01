package Dominion::Cards::Witch;

use Moose;
extends 'Dominion::Card';

sub name        { 'Witch' }
sub tags        { qw(kingdom action attack) }
sub box         { 'Dominion' }
sub cost_coin   { 5 }
sub cost_potion { 0 }

# Attack
# +2 Cards
# Each other player gains a Curse card.

#__PACKAGE__->meta->make_immutable;
1;
