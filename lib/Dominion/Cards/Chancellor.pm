package Dominion::Cards::Chancellor;

use Moose;
extends 'Dominion::Card';

has '+name'      => default => 'Chancellor';
has '+type'      => default => 'Action';
has '+set'       => default => 'Dominion';
has '+cost_coin' => default => 3;

# +2 Gold
# You may immediately put your deck into your discard pile.

#__PACKAGE__->meta->make_immutable;
1;
