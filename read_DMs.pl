#!/usr/bin/perl
use strict; 
use utf8;
use JSON;

# README
# This script takes a JSON file from a twitter data download, representing DMs,
# and creates multiple plain-text files with the contents of those DMs. 
# It runs locally and does NOT display the names of people in the convo.
# (That would require a lookup from twitter dot com). Instead it uses ID numbers.

# FIRST YOU MUST ALTER THE FIRST LINE OF THE INPUT FILE and remove the
# following text>>> window.YTD.direct_message.part0 =  
# After you do so, the first line of the file will merely be a square and a
# curly bracket.

# Run this script like so: 
# $ perl read_DMs.pl path/to/direct-message-modified.js

###########################################################

# open the DM JSON file from the twitter dump
my $inputfile = $ARGV[0] or 'direct-message.js';
open my $fh, '<', $inputfile or die "couldn't open file: $!";
undef $/;
my $json_data = <$fh>;
close $fh;

my @dms = @{decode_json($json_data)};

die "Hmm no DMs in $inputfile ?\n" unless @dms;
binmode(STDOUT, "encoding(UTF-8)"); # seems to help with emojis or something

my $j = 0; # unique identifier bc conversationId is not guaranteed unique

foreach my $convo (@dms){
    print "conversation ID: ", $convo->{dmConversation}{conversationId}, "\n\n";
    my @lines;

    foreach my $msg (@{$convo->{dmConversation}->{messages}}){
        unshift(@lines, "$msg->{messageCreate}->{createdAt} | $msg->{messageCreate}->{senderId} : $msg->{messageCreate}->{text}\n");
    }

        my $filename = "DM-convo-$convo->{dmConversation}{conversationId}-$j.txt";

        open(my $outfh, '>', $filename) or die "can't open outfile: $!";
        foreach my $line (@lines){
            print $outfh $line;
        }
        close($outfh);
        $j++;

}
