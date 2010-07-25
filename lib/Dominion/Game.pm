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
    foreach my $player ( $self->players ) {
        $player->reset;
        $player->deck->add($self->supply->gain('Copper')) for 1..7;
        $player->deck->add($self->supply->gain('Estate')) for 1..3;
        $player->deck->shuffle;
        $player->hand->add($player->deck->draw(5));
        $player->actions(1);
        $player->buys(1);
        $player->coin(0);
    }
}

#__PACKAGE__->meta->make_immutable;
1;
