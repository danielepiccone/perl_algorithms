#!/usr/bin/perl
use warnings;
use strict;
use Data::Dumper;
use Time::HiRes qw/ time sleep /;
use 5.010;

=head1 DESCRIPTION
Implementation of the bubble sort algorithm in Perl

=head1 AUTHOR
mail@danielepiccone.com

=cut

my $t = time();

# Test data
my @dat = ();
foreach (0 .. 1000){
    push @dat, rand(9999);
}

# Bubble sort
sub bubbleSort{
    my $swapping = 1;
    while ($swapping) {
        $swapping = 0;
        for (my $i = 1; $i < scalar(@_); $i++){
            if ($_[$i] < $_[$i-1]){
                $swapping = 1;
                @_[$i,$i-1] = @_[$i-1,$i];
            }
        }
    }
}

&bubbleSort(@dat);

# Print
foreach (@dat) {
    say $_
}

&lap;


### Subs

sub lap{
    say "--- Time:";
    say time()-$t;
}
