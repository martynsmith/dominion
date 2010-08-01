package Dominion::Cards::Province;

use Moose;
extends 'Dominion::Card';

sub name        { 'Province' }
sub tags        { qw(victory) }
sub box         { 'Dominion' }
sub cost_coin   { 8 }
sub cost_potion { 0 }

sub victory_points { 6 }

#__PACKAGE__->meta->make_immutable;
1;
