package Dominion::Cards::CouncilRoom;

use Moose;
extends 'Dominion::Card';

has '+name'      => default => 'Council Room';
has '+type'      => default => 'Action';
has '+set'       => default => 'Dominion';
has '+cost_gold' => default => 5;

# +4 Cards
# +1 Buy
# Each other player draws a card.

#__PACKAGE__->meta->make_immutable;
1;
