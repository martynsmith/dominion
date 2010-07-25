package Dominion::Cards::Smithy;

use Moose;
extends 'Dominion::Card';

has '+name'      => default => 'Smithy';
has '+type'      => default => 'Action';
has '+set'       => default => 'Dominion';
has '+cost_gold' => default => 4;

# +3 Cards

#__PACKAGE__->meta->make_immutable;
1;
