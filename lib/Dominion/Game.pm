package Dominion::Game;

use Moose;

use Dominion::Set::Supply;
use Dominion::Player;

has 'players' => (
    traits   => ['Array'],
    isa      => 'ArrayRef[Dominion::Player]',
    default  => sub { [] },
    handles  => {
        players      => 'elements',
        player_add   => 'push',
        player_count => 'count',
    },
);
has 'supply' => ( is => 'ro', isa => 'Dominion::Set::Supply', default => sub { Dominion::Set::Supply->new }, required => 1 );
has 'trash' => ( is => 'ro', isa => 'Dominion::Set', default => sub { Dominion::Set->new } );

sub start {
    my ($self) = @_;

    die "Invalid number of players: " . $self->player_count unless $self->player_count >= 2 and $self->player_count <= 8;

    $self->supply->init($self->player_count);
}

#__PACKAGE__->meta->make_immutable;
1;
