package Dominion::Cards::Spy;

use Moose;
extends 'Dominion::Card';

has '+name'      => default => 'Spy';
has '+type'      => default => 'Action';
has '+set'       => default => 'Dominion';
has '+cost_coin' => default => 4;

# Attack
# +1 Card,
# +1 Action
# Each player (including you) reveals the top card of his deck and either discards it or puts it back, your choice.

#__PACKAGE__->meta->make_immutable;
1;
