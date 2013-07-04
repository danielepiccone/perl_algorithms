#!/usr/bin/perl
use strict;
use warnings;
use diagnostics;
use Data::Dumper;
use Time::HiRes qw/ time sleep /;
use 5.010.0;


# Init
my $t = time();

main();

sub main{
    
    # Test data
    my @dat = map int rand(9999) , (0 .. 100);

    # Define K centroids
    my $num = 5;
    my @centroids;
    for my $i (0 .. $num){
        push @centroids, $dat[ int rand(@dat) ];   
    }

    
    # Main routine
    my ($centroids_ref, $clusters_ref) = kmeans( \@centroids, \@dat);
    # print Dumper $cen_ref;
    @centroids = @{$centroids_ref};
    my %clusters = %{$clusters_ref};
    
    # Dump
    for my $j (0 .. $num){
        printf "Centroid %d: %.2f \n", $j, $centroids[$j];
        say "\tCluster: @{$clusters{$j}}"; 
    } 

    lap();
}


#
# K-means Routine
#

sub kmeans{
    # Arguments
    
    my @centroids = @{$_[0]};
    my @dat = @{$_[1]};

    my $num = @centroids - 1;

     
    # Flush clusters
    my %clusters;
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
        return (\@centroids,\%clusters);
    }

    return kmeans(\@centroids, \@dat);
}


#
# Statistics Routine
#

sub lap{
    print "--- Time:" . (time()-$t) . "\n";
}








