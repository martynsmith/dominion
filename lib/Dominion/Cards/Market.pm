package Dominion::Cards::Market;

use Moose;
extends 'Dominion::Card';

has '+name'      => default => 'Market';
has '+type'      => default => 'Action';
has '+set'       => default => 'Dominion';
has '+cost_coin' => default => 5;

# +1 Card
# +1 Action
# +1 Buy
# +1 Gold

#__PACKAGE__->meta->make_immutable;
1;
