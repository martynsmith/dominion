package Dominion::AI::FullRetard;

use Moose;

extends 'Dominion::AI';

sub action {
    my ($self, $player, $state) = @_;

    my $card_name = ($player->hand->cards_of_type('action'))[0]->name;
    $player->play($card_name);
}

sub buy {
    my ($self, $player, $state) = @_;

    my $game = $player->game;

    my $coin = $player->coin;
    while ( $coin >= 0 ) {
        my @card_names = map { $_->name } grep { $_->cost_coin == $coin } $game->supply->cards;
        unless ( @card_names ) {
            $coin--;
            next;
        }
        my $card_name = @card_names[int rand() * @card_names];
        $player->buy($card_name);
        last;
    }
}

#__PACKAGE__->meta->make_immutable;
1;
