package Dominion::Cards::Market;

use Moose;
extends 'Dominion::Card';

sub name        { 'Market' }
sub tags        { qw(kingdom action) }
sub box         { 'Dominion' }
sub cost_coin   { 5 }
sub cost_potion { 0 }

# +1 Card
# +1 Action
# +1 Buy
# +1 Gold

#__PACKAGE__->meta->make_immutable;
1;
