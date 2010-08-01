package Dominion::Cards::Woodcutter;

use Moose;
extends 'Dominion::Card';

sub name        { 'Woodcutter' }
sub tags        { qw(kingdom action) }
sub box         { 'Dominion' }
sub cost_coin   { 3 }
sub cost_potion { 0 }

# +1 Buy
# +2 Gold

#__PACKAGE__->meta->make_immutable;
1;
