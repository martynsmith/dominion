package Dominion::Set;

use Moose;

has 'cards' => (
    traits   => ['Array'],
    isa      => 'ArrayRef[Dominion::Card]',
    default  => sub { [] },
    handles  => {
        add      => 'push',
        _shift   => 'shift',
        cards    => 'elements',
        count    => 'count',
        get      => 'get',
        _shuffle => 'shuffle',
        clear    => 'clear',
        grep     => 'grep',
        delete   => 'delete',
    },
);

sub draw {
    my ($self, $count) = @_;

    die "Need to specify a count" unless defined $count;

    my @cards;

    push @cards, $self->_shift while $count-- and $self->count;

    return @cards;
}

sub shuffle {
    my ($self) = @_;
    my @shuffled = $self->_shuffle;
    $self->clear;
    $self->add(@shuffled);
}

#__PACKAGE__->meta->make_immutable;
1;
