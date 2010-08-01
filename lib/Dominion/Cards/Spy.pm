package Dominion::Cards::Spy;

use Moose;
extends 'Dominion::Card';

sub name        { 'Spy' }
sub tags        { qw(kingdom action attack) }
sub box         { 'Dominion' }
sub cost_coin   { 4 }
sub cost_potion { 0 }

# Attack
# +1 Card,
# +1 Action
# Each player (including you) reveals the top card of his deck and either discards it or puts it back, your choice.

#__PACKAGE__->meta->make_immutable;
1;
