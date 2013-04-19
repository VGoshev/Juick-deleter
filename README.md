Juick-deleter
=============

Set of scripts for deleting Your post from Juick.

Scripts are written on Perl and hase following dependencies:
* JSON module ( http://search.cpan.org/~makamaka/JSON-2.57/ )

Usage:
======

* juick-delete-posts.pl - script for deleting all your Juick posts, except excludes. Using:
	juick-delete-posts.pl <Juick user name> <Juick HTTP-Password> [excludes]

Example:
	./juick-delete-posts.pl sunx Password 2316685 2315836 2315774
	
Also this script will write all recieved JSON answer to file "storage.<Juick user name>.txt"
