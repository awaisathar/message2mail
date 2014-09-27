use Irssi; use vars qw($VERSION %IRSSI); $VERSION = "1.0"; %IRSSI = (
    authors     => "Awais Athar",
    contact     => "https://github.com/awaisathar",
    name        => "message2mail",
    description => "Sends a mail when a user sends a private message.",
    license     => "Apache License Version 2.0",
    url => "https://github.com/awaisathar/message2mail", ); my $lastfrom, $lastquery; sub
msg_private_first {
  my ($server, $msg, $nick, $address) = @_;
  $lastquery = $server->query_find($nick);
}
sub msg_private {
  my ($server, $msg, $nick, $address) = @_;
  return if $lastquery || $lastfrom eq $nick;
  $lastfrom = $nick;
  $to='enter.your.email.here@mailinator.com';
  $from= $nick."@".$address;
  $subject=$msg;

        open(MAIL, "|/usr/sbin/sendmail -t");
        print MAIL "To: $to\n";
        print MAIL "From: $from\n";
        print MAIL "Subject: $subject\n\n";
        print MAIL "$msg\n";

        close(MAIL);
}
Irssi::signal_add_first('message private', 'msg_private_first');
Irssi::signal_add('message private', 'msg_private');
