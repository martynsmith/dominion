#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

use Data::Dump qw(dump);
use Dominion::Game;
use Dominion::AI::FullRetard;
use Dominion::AI::HalfRetard;
use Dominion::AI::MoneyWhore;

my $game = Dominion::Game->new();

my %players = (
    'Martyn'  => 'HalfRetard',
    'Forest'  => 'FullRetard',
    'Scrooge' => 'MoneyWhore',
    'Harry'   => 'HalfRetard',
);

foreach my $name ( keys %players ) {
    my $player = Dominion::Player->new(name => $name);
    $game->player_add($player);
    "Dominion::AI::$players{$name}"->new(player => $player);
}

$game->start;

until ( $game->state eq 'postgame' ) {
    #print "---\n";
    #my $player = $game->active_player;
    #dump({
    #    state   => $game->state,
    #    player  => $player->name,
    #    hand    => [ map { $_->name } $player->hand->cards ],
    #    play    => [ map { $_->name } $player->playarea->cards ],
    #    coin    => $player->coin,
    #    actions => $player->actions,
    #    buys    => $player->buys,
    #});
    $game->tick;
}

print "Game over\n";
print "---------\n";
foreach my $player ( sort { $a->name cmp $b->name } $game->players ) {
    my $vp = $player->deck->total_victory_points;
    printf "%s => %d points (%d cards) - ", $player->name, $vp, $player->deck->count;
    my $card_count = {};
    foreach my $card ( $player->deck->cards ) {
        next unless $card->is('victory') or $card->is('curse');
        $card_count->{$card->name}++;
    }
    print dump($card_count), "\n";
}
