package Dominion::Cards::Woodcutter;

use Moose;
extends 'Dominion::Card';

has '+name'      => default => 'Woodcutter';
has '+type'      => default => 'Action';
has '+set'       => default => 'Dominion';
has '+cost_gold' => default => 3;

# +1 Buy
# +2 Gold

#__PACKAGE__->meta->make_immutable;
1;
