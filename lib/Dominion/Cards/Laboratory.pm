package Dominion::Cards::Laboratory;

use Moose;
extends 'Dominion::Card';

sub name        { 'Laboratory' }
sub tags        { qw(kingdom action) }
sub box         { 'Dominion' }
sub cost_coin   { 5 }
sub cost_potion { 0 }

# +2 Cards
# +1 Action

#__PACKAGE__->meta->make_immutable;
1;
