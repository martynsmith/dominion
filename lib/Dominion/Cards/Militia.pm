package Dominion::Cards::Militia;

use Moose;
extends 'Dominion::Card';

has '+name'      => default => 'Militia';
has '+type'      => default => 'Action';
has '+set'       => default => 'Dominion';
has '+cost_gold' => default => 4;

# +2 Gold
# Each other player discards down to 3 cards in his hand.

#__PACKAGE__->meta->make_immutable;
1;
