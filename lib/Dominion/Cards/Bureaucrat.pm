package Dominion::Cards::Bureaucrat;

use Moose;
extends 'Dominion::Card';

has '+name'      => default => 'Bureaucrat';
has '+type'      => default => 'Action';
has '+set'       => default => 'Dominion';
has '+cost_gold' => default => 4;

# Attack
# Gain a silver card; put it on top of your deck.
# Each other player reveals a Victory card from his hand and puts it on his deck (or reveals a hand with no Victory cards).

#__PACKAGE__->meta->make_immutable;
1;
