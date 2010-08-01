package Dominion::Cards::Copper;

use Moose;
extends 'Dominion::Card';

sub name        { 'Copper' }
sub tags        { qw(treasure) }
sub box         { 'Dominion' }
sub cost_coin   { 0 }
sub cost_potion { 0 }

sub coin { 1 };

#__PACKAGE__->meta->make_immutable;
1;
