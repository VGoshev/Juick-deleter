Juick-deleter
=============

Set of scripts for deleting Your post from Juick.

Scripts are written on Perl and hase following dependencies:
* JSON module ( http://search.cpan.org/~makamaka/JSON-2.57/ )
* curl ( http://curl.haxx.se/ )

Usage:
======

* juick-delete-posts.pl - script for deleting all your Juick posts, except excludes. Using:<br />
	&nbsp;&nbsp;&nbsp;juick-delete-posts.pl &lt;Juick user name&gt; &lt;Juick HTTP-Password&gt [excludes]

Example:<br />
	&nbsp;&nbsp;&nbsp;./juick-delete-posts.pl sunx Password 2316685 2315836 2315774
	
Also this script will write all recieved JSON answer to file "storage.&lt;Juick user name&gt;.txt"
