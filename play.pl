#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

use Dominion::Game;
use Data::Dump qw(dump);

my $game = Dominion::Game->new();
my $p1 = Dominion::Player->new(name => 'Martyn');
my $p2 = Dominion::Player->new(name => 'Fred');
my $p3 = Dominion::Player->new(name => 'Harold');
$game->player_add($p1);
$game->player_add($p2);
$game->player_add($p3);
$game->start;

my $count = 0;
while ( 1 ) {
    my $state = $game->state;

    dump($state);

    given ( $state->{state} ) {
        when ( 'pregame' ) {
        }
        when ( 'gameover' ) {
            print "Game over\n";
            print "---------\n";
            foreach my $player ( $game->players ) {
                my $vp = $player->deck->total_victory_points;
                printf "%s => %d points (%d cards)\n", $player->name, $vp, $player->deck->count;
                my $card_count = {};
                foreach my $card ( $player->deck->cards ) {
                    next unless $card->is('victory');
                    $card_count->{$card->name}++;
                }
                dump($card_count);
            }
            exit 0;
        }
        when ( 'action' ) {
            my $card_name = ($game->active_player->hand->cards_of_type('action'))[0]->name;
            $game->active_player->play($card_name);
        }
        when ( 'buy' ) {
            my $coin = $state->{coin};
            while ( $coin >= 0 ) {
                my @card_names = map { $_->name } grep { $_->cost_coin == $coin } $game->supply->cards;
                unless ( @card_names ) {
                    $coin--;
                    next;
                }
                my $card_name = @card_names[int rand() * @card_names];
                $game->active_player->buy($card_name);
                last;
            }
        }
        default { die "Can't deal with state: $state->{state}" }
    }
}

