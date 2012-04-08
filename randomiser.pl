#!opt/local/perl
use warnings;
use strict;

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

my @stones;

open(STONES,"<stones.txt");
while (<STONES>) {
    my $line = $_;
    chomp $line;
    push (@stones, $line);
}

my %to_skip = multi_randomise(3,@stones);
foreach my $stone (keys %to_skip) {
    print $stone, "\n";
}