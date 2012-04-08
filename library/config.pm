package config;

use warnings;
use strict;

my $location; # insert location of the main perl script here
my $email = 'randomling.code@gmail.com'; # a contact email address for the site holder
my $text_file = "stones.txt"; # location of the text file from which we want to randomise answers

sub get_text_file {
    return $text_file;
}

sub get_location {
    return $location;
}

sub get_email {
    return $email;
}