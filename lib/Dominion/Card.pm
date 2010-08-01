package Dominion::Card;

use Moose;

sub name        { die "Name is required" }
sub tags        { qw() }
sub box         { die "Box is required" }
sub cost_coin   { die "Coin cost is required" }
sub cost_potion { die "Potion cost is required" }

has 'in_set' => ( isa => 'Dominion::Set', is => 'rw', trigger => \&remove_from_current_set );

sub is {
    my ($self, $tag) = @_;

    return scalar grep { $tag eq $_ } $self->tags;
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
