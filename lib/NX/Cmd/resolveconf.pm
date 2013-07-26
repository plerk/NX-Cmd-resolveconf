package NX::Cmd::resolveconf;

use strict;
use warnings;
use NX::Cmd::Resolvconf;

# ABSTRACT: Jealously edit resolve.conf
# VERSION

sub main
{
  my $cmd = shift;
  my @ARGV = @_;
  say 'redirect nx resolveconf => nx resolvconf';
  NX::Cmd::Resolvconf->main(@ARGV);
}

1;
