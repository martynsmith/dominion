package Dominion::Game;

use 5.010;
use Moose;
no warnings 'recursion';

with 'Dominion::EventEmitter';

use Dominion::Set::Supply;
use Dominion::Player;

has 'players' => (
    traits   => ['Array'],
    isa      => 'ArrayRef[Dominion::Player]',
    default  => sub { [] },
    handles  => {
        players         => 'elements',
        player_add      => 'push',
        player_count    => 'count',
        player_number   => 'get',
        player_clear    => 'clear',
        _player_shuffle => 'shuffle',
    },
);
has 'active_player' => ( is => 'rw', isa => 'Dominion::Player' );
has 'supply' => ( is => 'ro', isa => 'Dominion::Set::Supply', default => sub { Dominion::Set::Supply->new }, required => 1 );
has 'trash' => ( is => 'ro', isa => 'Dominion::Set', default => sub { Dominion::Set->new } );
has 'inplay' => ( is => 'rw', isa => 'Bool', default => 0 );

after 'player_add' => sub {
    my ($self, $player) = @_;

    $player->game($self);
};

sub player_shuffle {
    my ($self) = @_;
    my @shuffled = $self->_player_shuffle;
    $self->player_clear;
    $self->player_add(@shuffled);
}

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
        $player->add_listener('tick', sub { $self->player_ticked(shift) });
    }

    my @players = $self->player_shuffle;
    $self->active_player(($self->players)[0]);
    $self->inplay(1);
    $self->active_player->action_phase;
    $self->active_player->emit('tick');
}

sub finished_turn {
    my ($self, $player) = @_;

    die "You can't finish a turn when it's not your turn" unless $player == $self->active_player;

    $self->active_player($self->active_player->next_player);

    $self->active_player->action_phase();
}

sub check_endgame {
    my ($self) = @_;

    my $initial_piles = $self->supply->initial_piles;
    my $current_piles = $self->supply->current_piles;
    my $empty = scalar(keys %{$initial_piles}) - scalar(keys %{$current_piles});

    return $self->endgame unless exists $current_piles->{Province};

    given ( $self->player_count ) {
        when ( 2 ) { return $self->endgame if $empty >= 2; }
        default { return $self->endgame if $empty >= 3; }
    }
}

sub endgame {
    my ($self) = @_;

    $self->inplay(0);
    foreach my $player ( $self->players ) {
        $player->discard->add($player->hand->cards);
        $player->discard->add($player->playarea->cards);
        $player->deck->add($player->discard->cards);
    }
}

sub player_ticked {
    my ($self, $player) = @_;

    my $state = $self->state;
    $self->emit('tick', $state);
    $self->check_endgame;
    if ( $self->inplay ) {
        $self->active_player->emit('response_required', $state);
    }
    else {
        $self->emit('gameover');
    }
}

sub state {
    my ($self) = @_;

    my $player = $self->active_player;

    unless ( $player ) {
        return {
            state => 'pregame',
        }
    }

    my $state = {
        state       => $self->inplay ? $player->turnstate : 'gameover',
        player_id   => $player->id,
        player_name => $player->name,
        actions     => $player->actions,
        buys        => $player->buys,
        coin        => $player->coin,
        potion      => $player->potion,
    };

    return $state;
}


#__PACKAGE__->meta->make_immutable;
1;
