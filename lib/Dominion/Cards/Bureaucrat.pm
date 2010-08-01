package Dominion::Cards::Bureaucrat;

use Moose;
extends 'Dominion::Card';

sub name        { 'Bureaucrat' }
sub tags        { qw(kingdom action) }
sub box         { 'Dominion' }
sub cost_coin   { 4 }
sub cost_potion { 0 }

# Attack
# Gain a silver card; put it on top of your deck.
# Each other player reveals a Victory card from his hand and puts it on his deck (or reveals a hand with no Victory cards).

#__PACKAGE__->meta->make_immutable;
1;
