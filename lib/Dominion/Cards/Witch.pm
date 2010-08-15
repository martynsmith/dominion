package Dominion::Cards::Witch;

use Moose;
extends 'Dominion::Card';

sub name        { 'Witch' }
sub tags        { qw(kingdom action attack) }
sub box         { 'Dominion' }
sub cost_coin   { 5 }
sub cost_potion { 0 }

sub action {
    my ($self, $player, $game) = @_;

    # +2 Card
    $player->hand->add($player->draw(2));

    # Each other player gains a curse
    foreach my $other_player ( $player->other_players ) {
        $game->attack($self, $other_player, sub {
            my $curse = $game->supply->card_by_name('Curse');
            $other_player->discard->add($curse) if $curse;
        });
    }
}


#__PACKAGE__->meta->make_immutable;
1;
