package Dominion::Cards::Adventurer;

use Moose;
extends 'Dominion::Card';

sub name        { 'Adventurer' }
sub tags        { qw(kingdom action) }
sub box         { 'Dominion' }
sub cost_coin   { 6 }
sub cost_potion { 0 }

# Reveal cards from your deck until you reveal 2 Treasure cards.
# Put those Treasure cards in your hand and discard the other revealed cards.

#__PACKAGE__->meta->make_immutable;
1;
