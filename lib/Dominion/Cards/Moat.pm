package Dominion::Cards::Moat;

use Moose;
extends 'Dominion::Card';

sub name        { 'Moat' }
sub tags        { qw(kingdom action) }
sub box         { 'Dominion' }
sub cost_coin   { 2 }
sub cost_potion { 0 }

# Reaction
# +2 Cards
# When another player plays an Attack card, you may reveal this from your hand.
# If you do, you are unaffected by that attack.

#__PACKAGE__->meta->make_immutable;
1;
