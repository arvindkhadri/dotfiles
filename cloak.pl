use strict;
use warnings;
use Xchat qw( :all );

register(
    my $NAME    = "Fn Cloak+Join",
    my $VERSION = '4',
    "Join channels after a Freenode cloak takes effect"
    );
my $COMMAND  = 'CloakAndJoin'; # name of user command
my $USAGE    = 'Usage: '.$COMMAND.' [-u <account>] [-p <password>] <#list,#of,#channels> [<channel,keys>]'; # /help COMMAND
my $PREFIX   = "\cBCloak+Join\cB\t";
my $HOOK;

hook_command($COMMAND, sub {
    my ($w, $e) = @_;
    my ($account, $password, $args);

    my $i = 1;
    while ($$w[$i]) {
	if    ($$w[$i] eq '-p' && $$w[$i+1]) { $password = $$w[++$i] }
	elsif ($$w[$i] eq '-u' && $$w[$i+1]) { $account = $$w[++$i] }
	else { $args = $$e[$i]; last }
	$i++;
    }
    if ( not $args ) { prnt("$PREFIX$USAGE") }
    else {
	$args =~ s/(?<=,) //g if $args; # ' , '->','

	my ($channels, $keys) = split" ",$args,2;
	$_||='' for($channels, $keys); # optional

	# to keep out of the server on reconnect if not identified to services,
	# need to jump the irc_join_delay sky high and then bring back down to earth
	# this will only work if the nickserv password field in the network list
	# is populated
	my $delay = get_prefs("irc_join_delay");
	command("set -quiet irc_join_delay 3628800"); # 42 days!
	command("timer 1 set -quiet irc_join_delay $delay"); # back to earth after connection complete

	# identify if provided in command
	if ($password) {
	    if ($account) { command("ns identify $account $password") }
	    else { command("ns identify $password") }
	}

	# wait for response
	unhook $HOOK if $HOOK; # don't hook twice
	$HOOK = hook_server('396', sub {

	    my ($w, $e) = @_;
	    # this may change at some point
	    if( $$e[4] =~ /^:is now your hidden host/ ) { #
		# now join
		command("join $channels $keys");
		unhook $HOOK; undef($HOOK); # get rid of this hook
	    }
	    return EAT_NONE;
			    });
    }
    return EAT_XCHAT; # don't pass user command to server
	     }, {help_text=>$USAGE});
