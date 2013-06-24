#!/usr/bin/perl
use warnings;
use strict;
use Data::Dumper;
use Time::HiRes qw/ time sleep /;
use 5.010.0;

=head1 DESCRIPTION
Implementation of the quick sort algorithm in Perl

=head1 AUTHOR
mail@danielepiccone.com

=cut

my $t = time();

my @dat = ();

# Test data
foreach (0 .. 1000){
    push @dat, rand(9999);
}

# Quick sort
sub quickSort{
    # Termination
    if (int(@_) < 2){
        return @_;
    }

    # Get random Pivot
    my $p = rand(int(@_));
    my $pivot = $_[$p];
    # say $pivot;
    my @a;
    my @b;
    my @c;

    # Partition the Array in two parts, ordered
    foreach (@_){
        if ($_ < $pivot){
            push(@a,$_);
        }

        if ($_ > $pivot){
            push(@b,$_);
        }

        if ($_ == $pivot){
            push(@c,$_);
        }
    }


    # For each part do the same
    &quickSort(@a);

    &quickSort(@b);

    # Mutate array
    my @result = (@a,@c,@b);
    for (my $i = 0; $i < int(@_); $i++){
        $_[$i] = $result[$i];
    } 
    return 1;
}

&quickSort(@dat);

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
