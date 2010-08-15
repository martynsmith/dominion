package Dominion::Interaction::Question;

use Moose;
use Moose::Util::TypeConstraints;

extends 'Dominion::Interaction';

subtype 'Dominion::Interaction::Question::OptionList' => as 'ArrayRef[Dominion::Interaction::Question::Option]';

coerce 'Dominion::Interaction::Question::OptionList'
    => from 'ArrayRef[HashRef]'
        => via { [ map { Dominion::Interaction::Question::Option->new(%{$_}) } @{$_} ] }
    => from 'HashRef'
        => via { 
            my @list;
            foreach my $key ( sort keys %{$_} ) {
                push @list, Dominion::Interaction::Question::Option->new(
                    key => $key,
                    value => $_->{$key},
                );
            }
            \@list;
        }
;

has 'options' => (
    traits   => ['Array'],
    isa      => 'Dominion::Interaction::Question::OptionList',
    required => 1,
    coerce   => 1,
    handles  => {
        options => 'elements',
        grep    => 'grep',
    },
);
has 'selected' => (
    is      => 'rw',
    isa     => 'Dominion::Interaction::Question::Option',
    handles => {
        answer => 'key',
    },
);

sub choose {
    my ($self, $key) = @_;

    my ($option) = $self->grep(sub { $key eq $_->key });

    die "Invalid option key: $key" unless $option;

    $self->selected($option);
}

before 'done' => sub {
    my ($self) = @_;

    die "No selection made" unless $self->selected;
};

#__PACKAGE__->meta->make_immutable;
1;

package Dominion::Interaction::Question::Option;

use Moose;

has 'key' => ( is => 'ro', isa => 'Str' );
has 'value' => ( is => 'ro', isa => 'Str' );

#__PACKAGE__->meta->make_immutable;
1;
