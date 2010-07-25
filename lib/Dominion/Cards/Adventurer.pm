package Dominion::Cards::Adventurer;

use Moose;
extends 'Dominion::Card';

has '+name'      => default => 'Adventurer';
has '+type'      => default => 'Action';
has '+set'       => default => 'Dominion';
has '+cost_gold' => default => 6;

# Reveal cards from your deck until you reveal 2 Treasure cards.
# Put those Treasure cards in your hand and discard the other revealed cards.

#__PACKAGE__->meta->make_immutable;
1;
