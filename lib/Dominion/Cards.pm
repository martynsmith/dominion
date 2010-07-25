package Dominion::Cards;

use strict;
use warnings;
use Module::Pluggable sub_name => 'all', search_path => 'Dominion::Cards', require => 1;

__PACKAGE__->all;

sub victory { grep { $_->new->type eq 'Victory' } __PACKAGE__->all }
sub treasure { grep { $_->new->type eq 'Treasure' } __PACKAGE__->all }
sub action { grep { $_->new->type eq 'Action' } __PACKAGE__->all }

1;
