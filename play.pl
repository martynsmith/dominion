#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

use Dominion::Game;

my $game = Dominion::Game->new();
my $p1 = Dominion::Player->new(name => 'Martyn');
my $p2 = Dominion::Player->new(name => 'Fred');
my $p3 = Dominion::Player->new(name => 'Harold');
$game->player_add($p1);
$game->player_add($p2);
$game->player_add($p3);

use Dominion::AI::FullRetard;
use Dominion::AI::HalfRetard;
Dominion::AI::HalfRetard->new(player => $p1);
Dominion::AI::FullRetard->new(player => $p2);
Dominion::AI::FullRetard->new(player => $p3);

$game->add_listener('gameover', sub {
    print "Game over\n";
    print "---------\n";
    foreach my $player ( $game->players ) {
        my $vp = $player->deck->total_victory_points;
        printf "%s => %d points (%d cards)\n", $player->name, $vp, $player->deck->count;
        my $card_count = {};
        foreach my $card ( $player->deck->cards ) {
            next unless $card->is('victory') or $card->is('curse');
            $card_count->{$card->name}++;
        }
        use Data::Dump qw(dump);
        dump($card_count);
    }
});

$game->start;
