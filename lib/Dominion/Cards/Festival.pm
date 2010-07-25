package Dominion::Cards::Festival;

use Moose;
extends 'Dominion::Card';

has '+name'      => default => 'Festival';
has '+type'      => default => 'Action';
has '+set'       => default => 'Dominion';
has '+cost_gold' => default => 5;

# +2 Actions
# +1 Buy
# +2 Gold.

#__PACKAGE__->meta->make_immutable;
1;
