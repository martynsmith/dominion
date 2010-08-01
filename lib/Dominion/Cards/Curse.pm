package Dominion::Cards::Curse;

use Moose;
extends 'Dominion::Card';

has '+name'      => default => 'Curse';
has '+type'      => default => 'Curse';
has '+set'       => default => 'Dominion';
has '+cost_coin' => default => 0;

#__PACKAGE__->meta->make_immutable;
1;
