package Dominion::Cards::Library;

use Moose;
extends 'Dominion::Card';

has '+name'      => default => 'Library';
has '+type'      => default => 'Action';
has '+set'       => default => 'Dominion';
has '+cost_coin' => default => 5;

# Draw until you have 7 cards in hand.
# You may set aside any Action cards drawn this way, as you draw them; discard the set aside cards after you finish drawing.

#__PACKAGE__->meta->make_immutable;
1;
