package Dominion::Cards::Library;

use Moose;
extends 'Dominion::Card';

sub name        { 'Library' }
sub tags        { qw(kingdom action) }
sub box         { 'Dominion' }
sub cost_coin   { 5 }
sub cost_potion { 0 }

# Draw until you have 7 cards in hand.
# You may set aside any Action cards drawn this way, as you draw them; discard the set aside cards after you finish drawing.

#__PACKAGE__->meta->make_immutable;
1;
