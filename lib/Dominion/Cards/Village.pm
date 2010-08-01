package Dominion::Cards::Village;

use Moose;
extends 'Dominion::Card';

has '+name'      => default => 'Village';
has '+type'      => default => 'Action';
has '+set'       => default => 'Dominion';
has '+cost_coin' => default => 3;

# +1 Card
# +2 Actions

#__PACKAGE__->meta->make_immutable;
1;
