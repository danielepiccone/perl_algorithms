#!/usr/bin/perl
use warnings;
use strict;
use diagnostics;
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
for (0 .. 1000){
    push @dat, rand(9999);
}

# Bubble sort
sub bubble_sort{
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

&bubble_sort(@dat);

# Print
for (@dat) {
    print $_ . "\n";
}

&lap;


### Subs

sub lap{
    print "--- Time:" . (time()-$t) . "\n";
}
