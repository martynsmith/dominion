package Dominion::Cards::Silver;

use Moose;
extends 'Dominion::Card';

sub name        { 'Silver' }
sub tags        { qw(treasure) }
sub box         { 'Dominion' }
sub cost_coin   { 3 }
sub cost_potion { 0 }

sub coin { 2 };

#__PACKAGE__->meta->make_immutable;
1;
