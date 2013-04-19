#!/usr/bin/perl

use strict;
use warnings;
use JSON;

sub usage {
	"run $0 <Juick user name> <Juick HTTP-Password> [excludes]\n";
}

# Settings
my @curl = ('curl', '-s');

#Init
my $uname = shift(@ARGV) or die usage;
my $password = shift(@ARGV) or die usage;
my @exclude = @ARGV;

my $excludeQR = join '|', @exclude;
if ($excludeQR ne '') {
	$excludeQR = qr/^($excludeQR)$/;
} else {
	$excludeQR = qr/^$/;
}


my $json = JSON->new->allow_nonref;

my $uid;

my $curl;
my $jsonTxt;
my $pJSON;

#Open Log file
open my $storeFile, '>>', "storage.$uname.txt";

# Get UID
open $curl, '-|', @curl, "http://api.juick.com/users?uname=$uname" or die "Can not curl juick: $!, $@\n";
$jsonTxt = '';
while (<$curl>) {
	print $storeFile $_;
	$jsonTxt .= $_;
}
close $curl;

#$json_text   = $json->encode( $perl_scalar );
$pJSON = $json->decode($jsonTxt);

$uid = $pJSON->[0]->{uid};

print "User: $uname, UID: $uid\n";

my $oldJson = $jsonTxt;
$jsonTxt = '';
while ($oldJson ne $jsonTxt) {
	$oldJson = $jsonTxt;
	$jsonTxt = '';
	open $curl, '-|', @curl, "http://api.juick.com/messages?user_id=$uid" or die "Can not curl juick: $!, $@\n";
	while (<$curl>) {
		print $storeFile $_;
		$jsonTxt .= $_;
	}
	close $curl;

	$pJSON = $json->decode($jsonTxt);
	my $count = scalar @$pJSON;
	for (my $i=0; $i<$count; $i++) {
		my $mid = $pJSON->[$i]->{mid};
		if ($mid =~ /$excludeQR/) {
			print "Excluded: $mid\n";
			next;
		}
		print "Deleteing: $mid\n";
		open my $SendCmd, '-|', @curl, '-u', "$uname:$password", '--data', "body=D #$mid", 'http://api.juick.com/post' or die "Can not send command: $!, $@\n";
		my @a = <$SendCmd>;
		close $SendCmd;
		sleep 1;
	}

	#last; #FOR DEBUG
}

close $storeFile;
