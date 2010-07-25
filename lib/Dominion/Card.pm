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

=head2 coin

How much coin does this card give you by being in your hand? (Note that this
isn't the place for cards that give you more coin when you play them).

=cut
sub coin { 0 }

#__PACKAGE__->meta->make_immutable;
1;
