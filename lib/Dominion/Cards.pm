package Dominion::Cards;

use strict;
use warnings;
use Module::Pluggable sub_name => 'all', search_path => 'Dominion::Cards', require => 1;

__PACKAGE__->all;

sub victory  { grep { $_->is('victory')  } __PACKAGE__->all }
sub treasure { grep { $_->is('treasure') } __PACKAGE__->all }
sub kingdom  { grep { $_->is('kingdom')  } __PACKAGE__->all }
sub action   { grep { $_->is('action')   } __PACKAGE__->all }

1;
