package Dominion::Player;

use 5.010;
use Moose;
use Moose::Util::TypeConstraints;
use Digest::MD5 qw(md5_hex);

with 'Dominion::EventEmitter';

has 'id'        => ( is => 'ro', isa => 'Str', default => sub { substr(md5_hex(rand),0,8) } );
has 'name'      => ( is => 'rw', isa => 'Str' );
has 'hand'      => ( is => 'ro', isa => 'Dominion::Set', default => sub { Dominion::Set->new } );
has 'playarea'  => ( is => 'ro', isa => 'Dominion::Set', default => sub { Dominion::Set->new } );
has 'deck'      => ( is => 'ro', isa => 'Dominion::Set', default => sub { Dominion::Set->new } );
has 'discard'   => ( is => 'ro', isa => 'Dominion::Set', default => sub { Dominion::Set->new } );
has 'game'      => ( is => 'rw', isa => 'Dominion::Game', default => undef );

subtype 'TurnState'
  => as 'Str'
  => where { $_ eq 'waiting' or $_ eq 'action' or $_ eq 'buy' }
  => message { "Invalid turn state specified: $_" }
;

has 'turnstate' => (
    is => 'rw',
    isa => 'TurnState',
    default => 'waiting',
);

has 'actions'    => (
    traits => ['Number'],
    is => 'rw',
    isa => 'Int',
    default => 0,
    handles => {
        actions_add => 'add',
        actions_sub => 'sub',
    },
);
has 'buys'    => (
    traits => ['Number'],
    is => 'rw',
    isa => 'Int',
    default => 0,
    handles => {
        buys_add => 'add',
        buys_sub => 'sub',
    },
);
has 'coin'    => (
    traits => ['Number'],
    is => 'rw',
    isa => 'Int',
    default => 0,
    handles => {
        coin_add => 'add',
        coin_sub => 'sub',
    },
);
has 'potion'    => (
    traits => ['Number'],
    is => 'rw',
    isa => 'Int',
    default => 0,
    handles => {
        potion_add => 'add',
        potion_sub => 'sub',
    },
);

sub reset {
    my ($self) = @_;

    foreach my $set ( qw(hand playarea deck discard) ) {
        $self->$set->clear;
    }
}

sub response_required {
    my ($self, $state, $id) = @_;

    given ( $state ) {
        when ( [qw(action buy)] ) {
            $self->emit($state, {
                id      => $self->id,
                state   => $state,
                name    => $self->name,
                actions => $self->actions,
                buys    => $self->buys,
                coin    => $self->coin,
                potion  => $self->potion,
            });
        }
        default {
            die "Played needs to deal with state: $state";
        }
    }
}

sub action_phase {
    my ($self) = @_;

    $self->turnstate('action');

    $self->buy_phase if $self->actions == 0 or $self->hand->grep(sub { $_->is('action') }) == 0;
}

sub play {
    my ($self, $card_name) = @_;

    die "You're not currently in a game" unless $self->game;
    die "The game isn't currently in play" unless $self->game->inplay;
    die "You're not currently in the action-phase of your turn" unless $self->turnstate eq 'action';
    die "You must specify a card name to play" unless $card_name and not ref $card_name;

    my $card = $self->hand->card_by_name($card_name);

    die "There is no $card_name in your hand" unless $card;
    die "$card_name is not an action card" unless $card->is('action');

    $self->playarea->add($card);
    $self->actions($self->actions - 1);
    $card->action($self, $self->game);

    $self->buy_phase if $self->actions == 0 or $self->hand->grep(sub { $_->is('action') }) == 0;
}

sub buy_phase {
    my ($self) = @_;

    $self->turnstate('buy');
    $self->coin_add($self->hand->total_coin);
}

sub buy {
    my ($self, $card_name) = @_;

    die "You're not currently in a game" unless $self->game;
    die "The game isn't currently in play" unless $self->game->inplay;
    die "You're not currently in the buy-phase of your turn" unless $self->turnstate eq 'buy';
    die "You must specify a card name to buy" unless $card_name and not ref $card_name;

    my $card = $self->game->supply->card_by_name($card_name);

    die "There is no $card_name in the supply" unless $card;

    die "You can't afford a $card_name" if $card->cost_coin > $self->coin;
    die "You can't afford a $card_name" if $card->cost_potion > $self->potion;

    $self->coin_sub($card->cost_coin);
    $self->potion_sub($card->cost_potion);
    $self->buys($self->buys - 1);
    $self->discard->add($card);

    $self->cleanup_phase(1) if $self->buys == 0;
}

sub cleanup_phase {
    my ($self) = @_;

    # Put the playarea and hand cards onto the discard
    $self->discard->add($self->hand->cards);
    $self->discard->add($self->playarea->cards);

    # Draw a new hand
    $self->hand->add($self->draw(5));

    $self->actions(1);
    $self->buys(1);
    $self->coin(0);

    $self->turnstate('waiting');
    $self->game->finished_turn($self);
}

sub draw {
    my ($self, $count) = @_;

    my @drawn = $self->deck->draw($count);

    if ( @drawn < $count ) {
        $self->discard->shuffle;
        $self->deck->add($self->discard->cards);
        push @drawn, $self->deck->draw($count - @drawn);
    }
    return @drawn;
}

sub next_player {
    my ($self) = @_;

    my @players = $self->game->players;
    my $first;

    while ( my $player = shift @players ) {
        $first //= $player;
        last if $player == $self;
    }
    return shift @players || $first;
}

sub prev_player {
    my ($self) = @_;

    my @players = reverse $self->game->players;
    my $first;

    while ( my $player = shift @players ) {
        $first //= $player;
        last if $player == $self;
    }
    return shift @players || $first;
}

sub other_players {
    my ($self) = @_;

    return grep { $_ != $self } $self->game->players;
}

#__PACKAGE__->meta->make_immutable;
1;
