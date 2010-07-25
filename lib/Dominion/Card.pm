package Dominion::Card;

use Moose;

has 'name'      => ( isa => 'Str', is => 'ro', required => 1 );
has 'type'      => ( isa => 'Str', is => 'ro', required => 1 );
has 'set'       => ( isa => 'Str', is => 'ro', required => 1 );
has 'cost_gold' => ( isa => 'Int', is => 'ro', required => 1 );

#__PACKAGE__->meta->make_immutable;
1;
