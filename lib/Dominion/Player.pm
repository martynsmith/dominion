package Dominion::Player;

use Moose;

has 'name'    => ( is => 'rw', isa => 'Str' );
has 'hand'    => ( is => 'ro', isa => 'Dominion::Set', default => sub { Dominion::Set->new } );
has 'play'    => ( is => 'ro', isa => 'Dominion::Set', default => sub { Dominion::Set->new } );
has 'deck'    => ( is => 'ro', isa => 'Dominion::Set', default => sub { Dominion::Set->new } );
has 'discard' => ( is => 'ro', isa => 'Dominion::Set', default => sub { Dominion::Set->new } );

#__PACKAGE__->meta->make_immutable;
1;
