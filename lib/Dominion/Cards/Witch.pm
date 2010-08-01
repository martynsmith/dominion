package Dominion::Cards::Witch;

use Moose;
extends 'Dominion::Card';

has '+name'      => default => 'Witch';
has '+type'      => default => 'Action';
has '+set'       => default => 'Dominion';
has '+cost_coin' => default => 5;

# Attack
# +2 Cards
# Each other player gains a Curse card.

#__PACKAGE__->meta->make_immutable;
1;
