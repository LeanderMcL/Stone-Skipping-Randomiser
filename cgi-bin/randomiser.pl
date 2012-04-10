#!/usr/bin/perl
use warnings;
use strict;

# existing perl modules
use File::Slurp;
use CGI ':standard';

# modules existing within the codebase
use library::config;

sub randomise {
    my @array = @_;
    my $length = @array;
    my $num = int(rand($length));
    return $array[$num - 1];
}

sub multi_randomise {
    my ($max,@array) = @_;
    my $i = 1;
    my %returns;
    my $skip;
    while ($i <= $max) {
        $skip = randomise(@array);
        while (exists $returns{$skip}) {
            $skip = randomise(@array);
        }
        $returns{$skip} = 1;
        $i += 1;
    }
    return %returns;
}
my $num = param('num');
my $text = config::get_text_file;
my $file = read_file($text, array_ref => 1);
my @stones = @{$file};
my %to_skip = multi_randomise($num,@stones);

print header(-charset=>'utf-8');
print start_html(-title=>"Random stones!",-style=>{"src"=>"../library/styles/page_style.css");
print script({"src"=>"../library/navigation.js", "type"=>"text/javascript"},"");
print h1("Here are your random stones.");
foreach my $stone (keys %to_skip) { 
    print p($stone);
}
print end_html;