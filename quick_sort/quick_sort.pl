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
for (0 .. 1000){
	push @dat, rand(9999);
}

# Quick sort
sub quick_sort{
# Termination
	if (@_ < 2){
		return @_;
	}

# Get random Pivot
	my $p = rand(scalar(@_));
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
	quick_sort(@a);

	quick_sort(@b);

# Mutate array
	my @result = (@a,@c,@b);
	for (my $i = 0; $i < @_; $i++){
		$_[$i] = $result[$i];
	} 
	return 1;
}

quick_sort(@dat);


# Print
for (@dat) {
	print $_ . "\n";
}

lap();


### Subs

sub lap{
	print "--- Time:" . (time()-$t) . "\n";
}
