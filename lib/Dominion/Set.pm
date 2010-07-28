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
        reduce   => 'reduce',
    },
);

before 'add' => sub {
    my ($self, @cards) = @_;
    map { $_->in_set($self) } @cards;
};

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

sub total_coin {
    my ($self) = @_;

    return $self->reduce(sub {
        my ($a, $b) = @_;
        $a = $a->coin if UNIVERSAL::isa($a, 'Dominion::Card');
        $a + $b->coin;
    });
}

sub find_index {
    my ($self, $card) = @_;

    for ( my $i = 0; $i < $self->count; $i++ ) {
        return $i if $self->get($i) == $card;
    }
    return;
}

#__PACKAGE__->meta->make_immutable;
1;
