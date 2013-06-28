#!/usr/bin/perl
use warnings;
use strict;
use diagnostics;
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
for (0 .. 1000){
	push(@dat, rand(9999));
}

# Merge sort
sub merge_sort {
	my @x = @_;
# Termination:
# Return the array if length < 2
	return @_ if @_ < 2;

# Define half size
	my $m = int @_ / 2;
	my @a = merge_sort(@x[0 .. $m - 1]);
	my @b = merge_sort(@x[$m .. (@_-1)] );
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


merge_sort(@dat);

# Print
for (@dat) {
	print $_ . "\n";
}

lap();


### Subs

sub lap{
	print "--- Time:" . (time()-$t) . "\n";
}
