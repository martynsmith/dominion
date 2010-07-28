package Dominion::Card;

use Moose;

has 'name'      => ( isa => 'Str', is => 'ro', required => 1 );
has 'type'      => ( isa => 'Str', is => 'ro', required => 1 );
has 'set'       => ( isa => 'Str', is => 'ro', required => 1 );
has 'cost_gold' => ( isa => 'Int', is => 'ro', required => 1 );
has 'in_set'    => ( isa => 'Dominion::Set', is => 'rw', trigger => \&remove_from_current_set );

sub is {
    my ($self, $type) = @_;

    return 1 if $self->type eq $type;
    return;
}

sub remove_from_current_set {
    my ($self, $new, $old) = @_;

    return unless $old;

    my $index = $old->find_index($self);

    return unless defined $index;

    $old->delete($index);
}

=head2 coin

How much coin does this card give you by being in your hand? (Note that this
isn't the place for cards that give you more coin when you play them).

=cut
sub coin { 0 }

#__PACKAGE__->meta->make_immutable;
1;
