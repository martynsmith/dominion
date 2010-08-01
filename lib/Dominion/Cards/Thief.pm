package Dominion::Cards::Thief;

use Moose;
extends 'Dominion::Card';

sub name        { 'Thief' }
sub tags        { qw(kingdom action attack) }
sub box         { 'Dominion' }
sub cost_coin   { 4 }
sub cost_potion { 0 }

# Attack
# Each other player reveals the top 2 cards of his deck.
# If they revealed any Treasure cards, they trash one of them that you choose.
# You may gain any or all of these trashed cards.
# They discard the other revealed cards.

#__PACKAGE__->meta->make_immutable;
1;
