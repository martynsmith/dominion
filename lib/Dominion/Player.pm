package Dominion::Player;

use Moose;
use Moose::Util::TypeConstraints;

has 'name'      => ( is => 'rw', isa => 'Str' );
has 'hand'      => ( is => 'ro', isa => 'Dominion::Set', default => sub { Dominion::Set->new } );
has 'play'      => ( is => 'ro', isa => 'Dominion::Set', default => sub { Dominion::Set->new } );
has 'deck'      => ( is => 'ro', isa => 'Dominion::Set', default => sub { Dominion::Set->new } );
has 'discard'   => ( is => 'ro', isa => 'Dominion::Set', default => sub { Dominion::Set->new } );
has 'game'      => ( is => 'rw', isa => 'Dominion::Game', default => undef );

subtype 'TurnState'
  => as 'Str'
  => where { $_ eq 'waiting' or $_ eq 'action' or $_ eq 'buy' }
  => message { "Invalid turn state specified: $_" }
;

has 'turnstate' => ( is => 'rw', isa => 'TurnState', default => 'waiting' );

has 'actions' => ( is => 'rw', isa => 'Int', default => 0 );
has 'buys'    => ( is => 'rw', isa => 'Int', default => 0 );
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

    foreach my $set ( qw(hand play deck discard) ) {
        $self->$set->clear;
    }
}

sub action_phase {
    my ($self) = @_;

    $self->turnstate('action');
    print $self->name . " - Action Phase\n";

    unless ( $self->hand->grep(sub { $_->is('Action') }) ) {
        $self->buy_phase();
    }
}

sub buy_phase {
    my ($self) = @_;

    $self->turnstate('buy');
    $self->coin_add($self->hand->total_coin);

    print $self->name . " - Buy Phase (" . $self->coin . " coin)\n";
}

sub buy {
    my ($self, $card_name) = @_;

    die "You must specify a card name to buy" unless $card_name and not ref $card_name;
    die "You're not currently in a game" unless $self->game;
    die "You're not currently in the buy-phase of your turn" unless $self->turnstate eq 'buy';

    my $card = $self->game->supply->card_by_name($card_name);

    die "There is to $card_name in the supply" unless $card;

    die "You can't afford a $card_name" if $card->cost_coin > $self->coin;
    die "You can't afford a $card_name" if $card->cost_potion > $self->potion;

    $self->coin_sub($card->cost_coin);
    $self->potion_sub($card->cost_potion);
    $self->buys($self->buys - 1);
    $self->discard->add($card);

    $self->cleanup_phase if $self->buys == 0;
}

sub cleanup_phase {
    my ($self) = @_;

    print $self->name . " - Cleanup Phase\n";

    # Put the play and hand cards onto the discard
    $self->discard->add($self->hand->cards);
    $self->discard->add($self->play->cards);

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

#__PACKAGE__->meta->make_immutable;
1;
