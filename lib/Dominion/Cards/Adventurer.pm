package Dominion::Cards::Adventurer;

use Moose;
extends 'Dominion::Card';

sub name        { 'Adventurer' }
sub tags        { qw(kingdom action) }
sub box         { 'Dominion' }
sub cost_coin   { 6 }
sub cost_potion { 0 }

sub action {
    my ($self, $player, $game) = @_;

    # Reveal cards from your deck until you reveal 2 Treasure cards.
    # Put those Treasure cards in your hand and discard the other revealed cards.

    my @cards_to_discard;

    my $treasure_count = 0;

    until ($treasure_count == 2) {

        my ($card) = $player->draw(1);

        last unless $card;

        # check if the card is a treasure card
        if ( $card->is('treasure') ) {
            $player->hand->add($card);
            $treasure_count++;
        }
        else {
            push @cards_to_discard, $card;
        }

    }

    $player->discard->add(@cards_to_discard);
}

#__PACKAGE__->meta->make_immutable;
1;
