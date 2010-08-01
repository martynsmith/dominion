package Dominion::Cards::Estate;

use Moose;
extends 'Dominion::Card';

sub name        { 'Estate' }
sub tags        { qw(victory) }
sub box         { 'Dominion' }
sub cost_coin   { 2 }
sub cost_potion { 0 }

sub victory_points { 1 }

#__PACKAGE__->meta->make_immutable;
1;
