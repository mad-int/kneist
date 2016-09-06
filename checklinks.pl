#!/usr/bin/perl

use warnings;
use strict;

use HTTP::Status;
use WWW::Mechanize;

use Data::Dumper;

#

# Which encodings perl can handle.
# deflated e.g. no encoding should always be available.
# Other possiblities: gzip.
#print join(",", HTTP::Message::decodable())."\n";

my $bot = WWW::Mechanize->new();
#print Dumper($bot);
#$bot->default_header('Accept-Language' => "de, en");

$bot->add_handler("request_send", sub { $_[0]->dump(); return; });
$bot->add_handler("response_done", sub { shift->dump; return; });

my $starturl = "http://www.stephanlenhart.de/";

my $resp = $bot->get($starturl, 'Accept-Encoding' => 'deflate');
if(not $resp->is_success())
{
    die("Couldn't fetch url: `".$starturl."'");
}

print "\n";

my @linklist = $bot->links();
@linklist = map { $_->url_abs(); } @linklist;
print(join("\n", @linklist), "\n");
#for my $link (@linklist)
#{
#    print $link->url_abs()."\n";
#}

