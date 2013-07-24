package NX::Cmd::resolveconf;

use strict;
use warnings;
use autodie;
use 5.012;
use File::Temp qw( tempfile );
use IPC::Run qw( run );
use Getopt::Long qw( GetOptions );

# ABSTRACT: Jealously edit resolve.conf
# VERSION

sub main
{
  my $cmd = shift;
  my @ARGV = @_;

  my $editor = $ENV{EDITOR} // 'vi';

  GetOptions(
    'editor=s' => \$editor,
  );

  my($fh, $filename) = tempfile( "resolv-conf-XXXX", SUFFIX => '.conf', TMPDIR => 1 );

  open my $in, '<', '/etc/resolv.conf';
  my $old = do { local $/; <$in> };
  print $fh $old;
  close $in;
  close $fh;

  system $editor, $filename;

  open $in, '<', $filename;
  my $new = do { local $/; <$in> };
  close $in;

  if($new ne $old)
  {
    system qw( sudo chattr -i /etc/resolv.conf );
    system 'sudo', 'cp', $filename, '/etc/resolv.conf';
    system qw( sudo chattr +i /etc/resolv.conf );
  }

  unlink $filename;
}

1;
