package Dominion::EventEmitter;

use Moose::Role;

has 'listeners' => ( is => 'ro', isa => 'HashRef[ArrayRef[Code]]', default => sub { {} } );

sub add_listener {
    my ($self, $event, $code) = @_;

    push @{$self->listeners->{$event}}, $code;

    return;
}

sub remove_listener {
    my ($self, $event, $code) = @_;

    $self->listeners->{$event} = [grep { $_ != $code } @{$self->listeners->{$event}}];

    return;
}

sub remove_all_listeners {
    my ($self, $event) = @_;

    delete $self->listeners->{$event};

    return;
}

sub emit {
    my ($self, $event, @data) = @_;

    return unless exists $self->listeners->{$event} and ref $self->listeners->{$event} eq 'ARRAY';

    foreach my $listener ( @{$self->listeners->{$event}} ) {
        $listener->($self, @data);
    }
}

#__PACKAGE__->meta->make_immutable;
1;
