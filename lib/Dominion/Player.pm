package Dominion::Player;

use Moose;
use Moose::Util::TypeConstraints;

has 'name'      => ( is => 'rw', isa => 'Str' );
has 'hand'      => ( is => 'ro', isa => 'Dominion::Set', default => sub { Dominion::Set->new } );
has 'play'      => ( is => 'ro', isa => 'Dominion::Set', default => sub { Dominion::Set->new } );
has 'deck'      => ( is => 'ro', isa => 'Dominion::Set', default => sub { Dominion::Set->new } );
has 'discard'   => ( is => 'ro', isa => 'Dominion::Set', default => sub { Dominion::Set->new } );

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
    print $self->name . " - Buy Phase\n";

    $self->coin_add($self->hand->total_coin);

}

sub cleanup_phase {
    my ($self) = @_;

    print $self->name . " - Cleanup Phase\n";

    # Put the play and hand cards onto the discard
    $self->discard->add($self->hand->cards);
    $self->hand->clear;
    $self->discard->add($self->play->cards);
    $self->play->clear;

    # Draw a new hand
    $self->hand->add($self->draw(5));

    $self->actions(1);
    $self->buys(1);
    $self->coin(0);

    $self->turnstate('waiting');
}

sub draw {
    my ($self, $count) = @_;

    my @drawn = $self->deck->draw($count);

    if ( @drawn < $count ) {
        $self->discard->shuffle;
        $self->deck->add($self->discard->cards);
        $self->discard->clear;
        push @drawn, $self->deck->draw($count - @drawn);
    }
    return @drawn;
}

#__PACKAGE__->meta->make_immutable;
1;
