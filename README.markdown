captured
========

Quick screen capture and sharing application for Mac OS X.

By programmers for programmers
==============================

While I would love to tinker with this to make it easy to install (it is really easy to use once it is setup), it proved to be non-trivial.

So, I am making some assumptions about the environment that captured runs in. In particular it expects:

 * A decent understanding of scp and ssh
 * That [Growl](http://growl.info/) (and the [growlnotify](http://growl.info/documentation/growlnotify.php) command-line tool) are installed

With that said, once things are installed and configured it really is handy. 

Install
=======

to install captured:

	$ sudo gem install captured
	$ captured --install
	$ open -e ~/.captured.yml

Then you will need to exit that config file with the appropriate settings for your server.

When you install it will copy an example config file to ~/.captured.yml, which has a few examples of possible configuration types.

The simplest of this is to the scp type:

 * user - optional if your remote user is the same as your local user
 * password - optional if you have setup key pair authentication
 * host - the remote host name
 * url - the public url to the remote host+path
 * path - the remote path to upload to

<pre>
	upload:
	  type: scp
	  user: user
	  password: secret
	  host: example.com
	  path: path/to/captured/
	  url: "http://example.com/captured/"
</pre>



Icons
=====

Icons from the [Crystal Clear](http://www.everaldo.com/crystal/) icon set by [Everaldo Coelho](http://en.wikipedia.org/wiki/Everaldo_Coelho). – The icons are [licensed](http://www.everaldo.com/crystal/?action=license) under the [GNU Lesser General Public License (LGPL)](http://en.wikipedia.org/wiki/GNU_Lesser_General_Public_License).


Copyright
=========

Copyright (c) 2009 Christopher Sexton. See LICENSE for details.
