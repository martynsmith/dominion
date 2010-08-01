package Dominion::Game;

use Moose;

use Dominion::Set::Supply;
use Dominion::Player;

has 'players' => (
    traits   => ['Array'],
    isa      => 'ArrayRef[Dominion::Player]',
    default  => sub { [] },
    handles  => {
        players       => 'elements',
        player_add    => 'push',
        player_count  => 'count',
        player_number => 'get',
    },
);
has 'active_player' => ( is => 'rw', isa => 'Int', default => 0 );
has 'supply' => ( is => 'ro', isa => 'Dominion::Set::Supply', default => sub { Dominion::Set::Supply->new }, required => 1 );
has 'trash' => ( is => 'ro', isa => 'Dominion::Set', default => sub { Dominion::Set->new } );

after 'player_add' => sub {
    my ($self, $player) = @_;

    $player->game($self);
};

sub start {
    my ($self) = @_;

    die "Invalid number of players: " . $self->player_count unless $self->player_count >= 2 and $self->player_count <= 8;

    $self->supply->init($self->player_count);
    foreach my $player ( $self->players ) {
        $player->reset;
        $player->deck->add($self->supply->card_by_name('Copper')) for 1..7;
        $player->deck->add($self->supply->card_by_name('Estate')) for 1..3;
        $player->deck->shuffle;
        $player->hand->add($player->deck->draw(5));
        $player->actions(1);
        $player->buys(1);
        $player->coin(0);
    }

    $self->player_number($self->active_player)->action_phase();
}

sub finished_turn {
    my ($self, $player) = @_;

    my $active_player = $self->player_number($self->active_player);

    die "You can't finish a turn when it's not your turn" unless $player == $active_player;

    my $player_number = $self->active_player;
    print "Player: $player_number\n";
    $player_number++;
    print "Player: $player_number\n";
    $player_number = 0 if $player_number >= $self->player_count;
    print "Player: $player_number\n";
    $self->active_player($player_number);
    print "Player: $player_number\n";

    $active_player = $self->player_number($self->active_player);
    $active_player->action_phase();
}

#__PACKAGE__->meta->make_immutable;
1;
