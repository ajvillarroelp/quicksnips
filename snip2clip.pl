#!/usr/bin/perl
use strict;
use warnings;

my $HOME =  $ENV{'HOME'};

my $snipsound = "/usr/share/sounds/freedesktop/stereo/bell.oga";
my $soundapp = "mplayer";
my $snipdir="$HOME/.quicksnips";
my $snipfile="$HOME/.quicksnips/snip2.cr";
my $keyfile="$HOME/.quicksnips/.key";

if ($#ARGV+1 < 1 ){
	print "Error in params";
	system("zenity  --title Error --error --text \"snip2clip2.pl: No snippet index received!\"");
	exit 2;
}

my $storedpass=`cat $keyfile | openssl enc -base64 -d`;
#my $snip=`openssl aes-256-cbc -d -in $snipfile -pass pass:$storedpass | sed -r '/^#|^\\s*$/d' | sort | sed -n $ARGV[0]p | cut -d\; -f 2`;
my @sniplist=`openssl aes-256-cbc -d -in $snipfile -pass pass:${storedpass}`;
;
for (my $i=0; $i <  $#sniplist+1;$i++ ) {
	if ($sniplist[$i] =~ m/^#/) {
		#print "bef, $sniplist[$i]\n";
		splice @sniplist,$i,1;
		$i--;
	}
}
#Obtain text (second field)
my @line=split(";",$sniplist[$ARGV[0]-1]);
my $snip=$line[1];
chomp($snip);
#print "AA $sniplist[$ARGV[0]-1] -- $snip\n";

if ( $snip eq "" ) {
	system("notify-send -i ${snipdir}/mp2.jpeg 'Snippet number $ARGV[0] is empty! check snippet file'");
	exit 2;
}

# get delay
my $snipdelay = `$snipdir/echodelay.sh`;
chomp($snipdelay);
if ( $snipdelay == "" ){
	$snipdelay = 3;
}
system($soundapp." ".$snipsound." > /dev/null 2> /dev/null");
sleep ($snipdelay);
my $search=$snip;
if ($search =~ m/\\[0-9][0-9]/)  {
	print ("Case1!\n");

	my @a1;
	my @a2;

	@a1=split(/\\[0-9][0-9][0-9][0-9]/,$snip);
	@a2=split(/\\/,$snip);
	my $i=0;
	foreach my $item (@a1) {
		print "xdotool getactivewindow type ".$item."\n";
		system( "xdotool getactivewindow type \"".$item."\"");
		if ( defined($a2[$i+1]) ) {
			my $code=substr $a2[$i+1],0,4;

			print "xdotool getactivewindow key U$code\n";
			system("xdotool getactivewindow key U$code");
		} else {next;}
		$i++;
	}
} elsif ( $search =~ m/\|/ ) {
	print ("Case2! \n");
	my @credentials=split(m/\|/,$snip);
	#print "BB $credentials[0] -- $credentials[1]\n";
	system("xdotool getactivewindow type \"$credentials[0]\"");
	system("xdotool getactivewindow key Tab");
	system("xdotool getactivewindow type \"$credentials[1]\"");
} else{
	print ("Case3 default!\n");
	system("printf '%s' \"$snip\" | xclip -i -selection clipboard");
    system("xdotool getactivewindow type \"$snip\"");
}
