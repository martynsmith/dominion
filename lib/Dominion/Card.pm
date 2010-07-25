package Dominion::Card;

use Moose;

has 'name'      => ( isa => 'Str', is => 'ro', required => 1 );
has 'type'      => ( isa => 'Str', is => 'ro', required => 1 );
has 'set'       => ( isa => 'Str', is => 'ro', required => 1 );
has 'cost_gold' => ( isa => 'Int', is => 'ro', required => 1 );

sub is {
    my ($self, $type) = @_;

    return 1 if $self->type eq $type;
    return;
}
#__PACKAGE__->meta->make_immutable;
1;
