package Dominion::Cards::Gold;

use Moose;
extends 'Dominion::Card';

sub name        { 'Gold' }
sub tags        { qw(treasure) }
sub box         { 'Dominion' }
sub cost_coin   { 6 }
sub cost_potion { 0 }

sub coin { 3 };

#__PACKAGE__->meta->make_immutable;
1;

