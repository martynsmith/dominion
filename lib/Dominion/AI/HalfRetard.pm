package Dominion::AI::HalfRetard;

use 5.010;
use Moose;
use List::Util qw(shuffle);
no warnings 'recursion';

extends 'Dominion::AI';

sub action {
    my ($self, $player, $state) = @_;

    my $card;

    $card //= ($player->hand->grep(sub { $_->name eq 'Market' }))[0];
    $card //= ($player->hand->grep(sub { $_->name eq 'Village' }))[0];
    $card //= ($player->hand->grep(sub { $_->name eq 'Festival' }))[0];

    # Fallback
    $card //= ($player->hand->cards_of_type('action'))[0];

    print "I have:\n";
    print join("\n", map { $_->name } ($player->hand->cards_of_type('action')));
    print "\n";
    print "Playing: ", $card->name, "\n";
    print "-------\n";
    $player->play($card->name);
}

sub buy {
    my ($self, $player, $state) = @_;

    my $game = $player->game;

    my $coin = $state->{coin};
    my $card;

    given ( $coin ) {
        when ( 1 ) { return $player->cleanup_phase(); }
        when ( 2 ) { return $player->cleanup_phase(); }
        when ( 3 ) {
            foreach my $potential ( shuffle(qw(Village Silver)) ) {
                ($card) //= $game->supply->card_by_name($potential);
            }
        }
        when ( 4 ) {
            foreach my $potential ( shuffle(qw(Smithy Gardens)) ) {
                ($card) //= $game->supply->card_by_name($potential);
            }
        }
        when ( 5 ) {
            foreach my $potential ( shuffle(qw(Laboratory Market Festival)) ) {
                ($card) //= $game->supply->card_by_name($potential);
            }
        }
        when ( 6 ) {
            foreach my $potential ( shuffle(qw(Gold)) ) {
                ($card) //= $game->supply->card_by_name($potential);
            }
        }
    }

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
