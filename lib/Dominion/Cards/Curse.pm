package Dominion::Cards::Curse;

use Moose;
extends 'Dominion::Card';

sub name        { 'Curse' }
sub tags        { qw(curse) }
sub box         { 'Dominion' }
sub cost_coin   { 0 }
sub cost_potion { 0 }

sub victory_points { -1 }

#__PACKAGE__->meta->make_immutable;
1;
