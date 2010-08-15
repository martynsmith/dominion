package Dominion::AI;

use 5.010;
use Moose;
use Moose::Util::TypeConstraints;

with 'Dominion::EventEmitter';

has 'curried_callbacks' => ( # {{{
    is  => 'ro',
    isa => 'HashRef',
    default => sub {
        my ($self) = @_;

        my $curried_callbacks = {};

        foreach my $cb ( qw(action buy interaction) ) {
            $curried_callbacks->{$cb} = sub { $self->$cb(@_) };
        }

        return $curried_callbacks;
    },
); # }}}

has 'player' => (
    is       => 'rw',
    isa      => 'Dominion::Player',
    trigger  => sub {
        my ($self, $player, $old_player) = @_;

        if ( $old_player ) {
            foreach my $cb ( keys %{$self->curried_callbacks} ) {
                $old_player->remove_listener($cb, $self->curried_callbacks->{$cb});
            }
        }

        foreach my $cb ( keys %{$self->curried_callbacks} ) {
            $player->add_listener($cb, $self->curried_callbacks->{$cb});
        }
    },
);

sub response_required {
    my $self = shift;
    my ($player, $state) = @_;

    print "WTF!\n" unless $player->name eq $self->player->name;

    given ( $state->{state} ) {
        when ( 'action' ) { $self->action(@_) }
        when ( 'buy' ) { $self->buy(@_) }
        default { die "Don't know how to deal with state: $state->{state}" }
    }
}

sub action {
    die "Need to implement action";
}

sub buy {
    die "Need to implement buy";
}

sub interaction {
    my ($self, $player, $state) = @_;

    my $interaction = $state->{interaction};

    match_on_type $interaction => (
        'Dominion::Interaction::Attack' => sub {
            $self->attack($player, $state, $interaction);
        },
        'Dominion::Interaction::Question' => sub {
            $self->question($player, $state, $interaction);
        },
        sub {
            die "Can't deal with interaction: " . ref $interaction;
        },
    );
}

sub attack {
    my ($self, $player, $state, $attack) = @_;

    die "Need to implement attack";
}

#__PACKAGE__->meta->make_immutable;
1;

