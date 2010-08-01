package Dominion::Cards::Chancellor;

use Moose;
extends 'Dominion::Card';

sub name        { 'Chancellor' }
sub tags        { qw(kingdom action) }
sub box         { 'Dominion' }
sub cost_coin   { 3 }
sub cost_potion { 0 }

# +2 Gold
# You may immediately put your deck into your discard pile.

#__PACKAGE__->meta->make_immutable;
1;
