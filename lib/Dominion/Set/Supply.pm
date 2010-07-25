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

    $self->add(map { Dominion::Cards::Estate->new   } 1..24);
    $self->add(map { Dominion::Cards::Duchy->new    } 1..12);
    $self->add(map { Dominion::Cards::Province->new } 1..12);
    $self->add(map { Dominion::Cards::Curse->new    } 1..30);
    $self->add(map { Dominion::Cards::Copper->new   } 1..60);
    $self->add(map { Dominion::Cards::Silver->new   } 1..40);
    $self->add(map { Dominion::Cards::Gold->new     } 1..30);

    my $actions = Dominion::Set->new();
    $actions->add(map { $_->new } Dominion::Cards->action);
    $actions->shuffle;
    $self->add($actions->draw(10));
}
