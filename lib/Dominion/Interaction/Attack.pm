package Dominion::Interaction::Attack;

use Moose;

extends 'Dominion::Interaction';

has 'cancelled' => ( is => 'rw', isa => 'Bool', default => 0 );

sub play {
    my ($self, $card_name) = @_;

    my $card = $self->player->hand->card_by_name($card_name);

    $card->reaction($self->player, $self->player->game, $self);
}

sub cancel {
    my ($self) = @_;

    $self->cancelled(1);
}

sub done {
    my ($self) = @_;

    $self->callback->() if $self->callback and not $self->cancelled;
    $self->resolved(1);
}

#__PACKAGE__->meta->make_immutable;
1;
