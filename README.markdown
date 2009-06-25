captured
========

Quick screen capture and sharing application for Mac OS X.


Install
=======

to install captured:

	$ sudo gem install csexton-captured -s http://gems.github.com
	$ captured --install
	$ open -e ~/.captured.yml

Then you will need to exit that config file with the approprate settings for your server.

The simplest way is to use the scp type.

 * user - optinal if your remote user is the same as your local user
 * password - optional if you have setup key pair authentication
 * host - the remote host name
 * url - the public url to the remote host+path
 * path - the remote path to upload to

	upload:
	  type: scp
	  user: user
	  host: example.com
	  path: example.com/captured/
	  url: "http://example.com/captured/"



Icons
=====

Icons from the [Crystal Clear](http://www.everaldo.com/crystal/) icon set by [Everaldo Coelho](http://en.wikipedia.org/wiki/Everaldo_Coelho). – The icons are [licensed](http://www.everaldo.com/crystal/?action=license) under the [GNU Lesser General Public License (LGPL)](http://en.wikipedia.org/wiki/GNU_Lesser_General_Public_License).


Copyright
=========

Copyright (c) 2009 Christopher Sexton. See LICENSE for details.
