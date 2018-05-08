#! /usr/bin/perl -w
use strict;
use lib "/projects/eh/bin/";        #add bin to the library path
use shared;

my $USAGE = "
$0 speciesname < orig_fa > new_fa

Preprocess sequence names into the format needed for multiz alignments.
>species:chrom:1:+:size
";

die $USAGE unless @ARGV==1;
my ($species) = @ARGV;

while(1) {
    my ($name, $seq) = read_fasta(\*STDIN);
    last unless defined $name;
    my $len = length($$seq);
    $name =~ s/^>//;
    $name =~ s/\s.*$//;  # remove all after first space
    die $name if $name eq "" || $name=~ />/ || $name=~/\s/;;
    $name = ">$species:$name:1:+:$len";
    write_fasta(\*STDOUT, $name, $seq);
}
