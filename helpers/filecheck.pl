#!/usr/bin/perl

while (<>) {
	if (/conda.anaconda.org\/([^\/]+)/ && $1 ne "conda-forge") { die "Unlicensed anaconda channel found: $1\n" }
}

