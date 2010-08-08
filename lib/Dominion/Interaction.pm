package Dominion::Interaction;

use Moose;

my $interaction_id = 0;

has 'id'       => ( is => 'ro', isa => 'Int', default => sub { $interaction_id++ } );
has 'resolved' => ( is => 'rw', isa => 'Bool', default => 0 );
has 'player'   => ( is => 'rw', isa => 'Dominion::Player' );
has 'callback' => ( is => 'rw', isa => 'CodeRef' );

sub done {
    my ($self) = @_;

    $self->callback->() if $self->callback;
    $self->resolved(1);
}

#__PACKAGE__->meta->make_immutable;
1;
