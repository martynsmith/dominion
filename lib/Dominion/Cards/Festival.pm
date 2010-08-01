package Dominion::Cards::Festival;

use Moose;
extends 'Dominion::Card';

sub name        { 'Festival' }
sub tags        { qw(kingdom action) }
sub box         { 'Dominion' }
sub cost_coin   { 5 }
sub cost_potion { 0 }

# +2 Actions
# +1 Buy
# +2 Gold.

#__PACKAGE__->meta->make_immutable;
1;
