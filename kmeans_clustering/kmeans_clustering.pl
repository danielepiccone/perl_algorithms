#!/usr/bin/perl
use strict;
use warnings;
use diagnostics;
use Data::Dumper;
use Time::HiRes qw/ time sleep /;
use 5.010.0;

# Init
my $t = time();
my $val = 0;
my $num = 5;
my %clusters = ();

# Test data
my @dat = ();
for (0 .. 100){
    push @dat, int(rand(9999));
}

# print Dumper @dat;

# Define K centroids
my @centroids;
for my $i (0 .. $num){
    push( @centroids,$dat[int(rand(@dat))] );   
}

# Init
my $pass = 0;
while (kmeans()){
    $pass++
}

#Dump
    foreach my $j (0 .. $num){
        print "Centroid $j: $centroids[$j] \n";
        print "Cluster [ @{$clusters{$j}} ] \n";
    } 


print "Done in $pass passes.\n";
lap();

#
# Main Routine
#

sub kmeans{
# Single Step

# Flush clusters
    for my $i (0 .. $num){
        $clusters{$i} = [];
    }

# Memorize last centroid values
    my @centroids_old = @centroids;

# Find distance beetween points and classificate them by clusters
    foreach (@dat){
        my $pt = $_;
        my $min_distance = 9999999999;
        my $close_to;

        for my $i (0 .. $num){
            my $ct = $centroids[$i];

            my $d = abs($pt - $ct);

            if ($d < $min_distance){
                $min_distance = $d;
                $close_to = $i;
            }
        }

        # Put in the chosen cluster, each cluster refer to a centroid
        push($clusters{$close_to},$pt);
    }



# Replace means with the mean of cluster k
    for my $i (0 .. $num){
        my $mean =0;
        my $n = 0;
        foreach(@{$clusters{$i}}){
            $mean += $_;
            $n++;
        }
        $mean = $mean / ($n || 1);
        $centroids[$i] = $mean;
    }

# Check if difference is under threshold = 0.1
    my $lastpass = 1;
    for my $i (0 .. $num){
        my $deviance = abs($centroids[$i] - $centroids_old[$i]);
        if ($deviance > 0.0){
            $lastpass = 0;
        }
    }

    if ($lastpass == 1){
        return 0;
    }

# Dump
#    foreach my $j (0 .. $num){
#        print "---------- $centroids[$j] \n";
#        print "@{$clusters{$j}} \n";
#    } 
 
    return 1;
}



### Subs

sub lap{
    print "--- Time:" . (time()-$t) . "\n";
}







