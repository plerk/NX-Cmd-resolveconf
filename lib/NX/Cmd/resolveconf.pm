package NX::Cmd::resolveconf;

use strict;
use warnings;
use v5.10;
use NX::Cmd::resolvconf;

# ABSTRACT: Jealously edit resolve.conf
# VERSION

sub main
{
  my $cmd = shift;
  my @ARGV = @_;
  say 'redirect nx resolveconf => nx resolvconf';
  NX::Cmd::resolvconf->main(@ARGV);
}

1;
