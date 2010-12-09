captured
========

Quick screen capture and sharing for Mac OS X.

Screen Capture Sharing Tool
===========================

<img src="https://github.com/csexton/captured/raw/master/resources/captured.png" align="right" />

I made captured because I wanted to customize and extend screen capture sharing programs, it is really intended for the commandline savvy.

So, I am making some assumptions about the environment that captured runs in. In particular it expects:

 * A decent understanding of installing ruby gems
 * That [Growl](http://growl.info/) is installed

With that said, once things are installed and configured it really is handy.

Install
=======

To install captured:

    $ sudo gem install captured
    $ captured --install

When you install an example config file to ~/.captured.yml, which has a few examples of possible configuration types.

Using Captured
==============

The main use is to upload a screen shot taken using OS X's built in screen capture.

 1. Press ⌘-⇧-4 to capture
 2. Paste the link

Captured can also be used from the command line to easily share files.

 1. Run `captured path/to/file`
 2. Paste the link

Configuration
=============

By default captured uses Imgur as the default host, but you can configure it to upload and share images by other services.

To edit the configuraiton:

    $ open -e ~/.captured.yml

Type: Imgur
-----------
The simple image sharer. The default option.

<pre>
upload:
  type: imgur
</pre>

Type: Imageshack
----------------
This service is a little slower, but is free and easy.

<pre>
upload:
  type: imageshack
</pre>


Type: scp
---------

If you have you own web server scp is a very handy way to host your own captures.

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

The Logo was made from the fantastic Vector Wood Signs by [DragonArt](http://dragonartz.wordpress.com) under the [Creative Commons Attribution-Noncommercial-Share Alike 3.0 United States License](http://creativecommons.org/licenses/by-nc-sa/3.0/us/).

Copyright
=========

Copyright (c) 2010 Christopher Sexton. See LICENSE for details.
