#!/usr/bin/perl

# creat some files with nasty names
#
# For more information why Unix and filesystems that do not enforce UTF-8
# and some additional restrictions suck, read http://short.to/314y8

$t = "ASCII control character";
badname(chr($_),$t) foreach (0..31,127);

$t = "Forbidden in some file systems";
badname($_,$t) foreach split(//,' \'"*:<>?\\/|%');

$t = "Nasty in shell code";
badname($_,$t) foreach split(//,'$[]{};');

$t = "Byte Order Mark (BOM)";
badname($_,$t) foreach ("\xFF\xEE","\xFF\xFE","\xEF\xBB\xBF");

$t = "Dots";
badname($_,$t) foreach (".","..","...",".x","x.");

# TODO: Add badly escaped UTF-8

sub badname {
  my ($s,$t) = @_;
  $t .= "\n" . join('', map {sprintf("%02X ",ord($_))} split(//,$s) ) . "= $s";
  $t =~ s/'/'\\''/;
  $s =~ s/'/'\\''/;
  print "$t\n";
  system("echo '$t' > '$s'");
}

