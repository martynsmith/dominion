package Dominion::Cards::Moat;

use Moose;
extends 'Dominion::Card';

has '+name'      => default => 'Moat';
has '+type'      => default => 'Action';
has '+set'       => default => 'Dominion';
has '+cost_gold' => default => 2;

# Reaction
# +2 Cards
# When another player plays an Attack card, you may reveal this from your hand.
# If you do, you are unaffected by that attack.

#__PACKAGE__->meta->make_immutable;
1;
