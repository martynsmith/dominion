package Dominion::Cards::Gardens;

use Moose;
extends 'Dominion::Card';

sub name        { 'Gardens' }
sub tags        { qw(kingdom victory) }
sub box         { 'Dominion' }
sub cost_coin   { 4 }
sub cost_potion { 0 }

# Worth 1 Victory for every 10 cards in your deck (rounded down).

#__PACKAGE__->meta->make_immutable;
1;
