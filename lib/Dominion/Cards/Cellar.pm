package Dominion::Cards::Cellar;

use Moose;
extends 'Dominion::Card';

has '+name'      => default => 'Cellar';
has '+type'      => default => 'Action';
has '+set'       => default => 'Dominion';
has '+cost_coin' => default => 2;

# +1 Action
# Discard any number of cards. +1 Card per card discarded

#__PACKAGE__->meta->make_immutable;
1;
