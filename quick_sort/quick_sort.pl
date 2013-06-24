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
    if (int(@_) < 1){
        return @_;
    }

    # Get random Pivot
    my $pivot = $_[rand(int(@_))];

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
    @a = &quickSort(@a);

    @b = &quickSort(@b);

    # Until ordered
    my @merged = (@a,@c,@b);
    return @merged;
}

@dat = &quickSort(@dat);

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
