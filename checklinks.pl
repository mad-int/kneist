#!/usr/bin/perl

use warnings;
use strict;

use HTTP::Status;
use WWW::Mechanize;

use Data::Dumper;

#

my $bot = WWW::Mechanize->new();
#print Dumper($bot);

my $starturl = "http://www.stephanlenhart.de/";

my $resp = $bot->get($starturl);
if(not $resp->is_success())
{
    die("Couldn't fetch url: `".$starturl."'");
}

my @linklist = $bot->links();
@linklist = map { $_->url_abs(); } @linklist;
print(join("\n", @linklist), "\n");
#for my $link (@linklist)
#{
#    print $link->url_abs()."\n";
#}

