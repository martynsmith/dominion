package Dominion::Set::Supply;

use 5.010;

use Moose;
extends 'Dominion::Set';

use Dominion::Cards;

sub init {
    my ($self, $player_count) = @_;

    die "Must specify number of players" unless defined $player_count;
    die "Player count must be between 2 and 8" unless $player_count >= 2 and $player_count <= 8;

    $self->clear;

    my %card_count_for = (
        'Dominion::Cards::Estate'   => 24,
        'Dominion::Cards::Duchy'    => 12,
        'Dominion::Cards::Province' => 12,
        'Dominion::Cards::Curse'    => 30,
        'Dominion::Cards::Copper'   => 60,
        'Dominion::Cards::Silver'   => 40,
        'Dominion::Cards::Gold'     => 30,
    );

    given ( $player_count ) {
        # TODO, put real numbers in here for different player counts
        when (2) {
            $card_count_for{'Dominion::Cards::Estate'}   = 24;
            $card_count_for{'Dominion::Cards::Duchy'}    = 12;
            $card_count_for{'Dominion::Cards::Province'} = 12;
        }
        when (3) {
            $card_count_for{'Dominion::Cards::Estate'}   = 24;
            $card_count_for{'Dominion::Cards::Duchy'}    = 12;
            $card_count_for{'Dominion::Cards::Province'} = 12;
        }
    }

    foreach my $card ( keys %card_count_for ) {
        $self->add(map { $card->new   } 1 .. $card_count_for{$card});
    }

    my $actions = Dominion::Set->new();
    $actions->add(map { $_->new } Dominion::Cards->action);
    $actions->shuffle;
    foreach my $action ( $actions->draw(10) ) {
        $self->add(map { (ref $action)->new } 1..10);
    }
}

sub gain {
    my ($self, $name) = @_;

    for ( my $i = 0; $i < $self->count; $i++ ) {
        if ( $self->get($i)->name eq $name ) {
            return $self->delete($i);
        }
    }
    return;
}
