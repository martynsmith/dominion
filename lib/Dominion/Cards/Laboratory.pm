package Dominion::Cards::Laboratory;

use Moose;
extends 'Dominion::Card';

has '+name'      => default => 'Laboratory';
has '+type'      => default => 'Action';
has '+set'       => default => 'Dominion';
has '+cost_gold' => default => 5;

# +2 Cards
# +1 Action

#__PACKAGE__->meta->make_immutable;
1;
