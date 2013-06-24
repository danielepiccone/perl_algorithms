#!/usr/bin/perl
use warnings;
use strict;
use Data::Dumper;
use Time::HiRes qw/ time sleep /;
use 5.010;

=head1 DESCRIPTION
Implementation of the merge sort algorithm in Perl

=head1 AUTHOR
mail@danielepiccone.com

=cut

my $t = time();

# Test data
my @dat = ();
foreach (0 .. 1000){
push @dat, rand(9999);
}

# Merge sort
sub mergeSort {
    my @x = @_;
    # Termination:
    # Return the array if length < 2
    return @_ if int(@_) < 2;
    
    # Define half size
    my $m = int @_ / 2;
    my @a = &mergeSort(@x[0 .. $m - 1]);
    my @b = &mergeSort(@x[$m .. (int(@_)-1)] );
    for (@_) {
        if (!@a){
            $_ = shift @b;
        }elsif (!@b){
            $_= shift @a;
        }elsif ($a[0] <= $b[0]){
            $_ = shift @a;           
        }else{
            $_= shift @b;
        }
    }
    return @_;
}


&mergeSort(@dat);

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
