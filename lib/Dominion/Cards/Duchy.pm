package Dominion::Cards::Duchy;

use Moose;
extends 'Dominion::Card';

sub name        { 'Duchy' }
sub tags        { qw(victory) }
sub box         { 'Dominion' }
sub cost_coin   { 5 }
sub cost_potion { 0 }

sub victory_points { 3 }

#__PACKAGE__->meta->make_immutable;
1;
