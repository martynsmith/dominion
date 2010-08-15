package Dominion::Cards::Library;

use Moose;
extends 'Dominion::Card';

sub name        { 'Library' }
sub tags        { qw(kingdom action) }
sub box         { 'Dominion' }
sub cost_coin   { 5 }
sub cost_potion { 0 }

has 'stash' => ( is => 'ro', isa => 'Dominion::Set', default => sub { Dominion::Set->new } );

sub action {
    my ($self, $player, $game) = @_;

    $self->stash->clear;

    # Draw until you have 7 cards in hand.
    # You may set aside any Action cards drawn this way, as you draw them;
    # discard the set aside cards after you finish drawing.
    $self->draw($player, $game);
}

sub draw {
    my ($self, $player, $game) = @_;

    while ( $player->hand->count < 7 ) {
        my ($card) = $player->draw(1);

        # If card is an action, ask user if they want to put it into their hand
        # or not
        if ( $card->is('action') ) {
            $game->interaction_add(Dominion::Interaction::Question->new(
                player   => $player,
                card     => $self,
                message => 'Do you want to keep or set aside: ' . $card->name,
                options => {
                    0 => 'Keep it',
                    1 => 'Set is aside',
                },
                callback => sub {
                    my ($question) = @_;

                    if ( $question->answer == 0 ) {
                        $player->hand->add($card);
                    }
                    else {
                        $self->stash->add($card);
                    }
                    if ( $player->hand->count < 7 ) {
                        # If they still don't have 7 cards, continue drawing
                        $self->draw($player, $game);
                    }
                    else {
                        $player->discard->add($self->stash->cards);
                    }
                }
            ));
            # This method is now done, the drawing will be continued in the
            # callback
            last;
        }

        $player->hand->add($card);
    }

    $player->discard->add($self->stash->cards) if $player->hand->count == 7;
}


#__PACKAGE__->meta->make_immutable;
1;
