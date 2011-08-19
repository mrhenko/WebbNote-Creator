WebbNote Creator
================

What?
--------
WebbNote Creator is a command line tool to convert documents marked up as ["Markdown"][1] into [WebbNote][2] compatible HTML. It is written in Perl and should work seamlessly on Linux/*nix/OS X.

It was created by [Henrik Carlsson][3] in 2011. Neither Henrik nor the WebbNote Creator is in anyway affiliated with and/or endorsed by [John Gruber][4]

How?
-------
Just run it from the command line:
	$ ./webbnote-creator.pl <your markdown file>

Writing the presentation
-------------------------------
With WebbNote Creator you write your presentation in any plain text editor, and use Markdown whenever appropriate. To make a new slide, simply use the tag

	[newslide]

(You don't have to start your document with a [newslide] tag.) Any additional HTML needed will be added by WebbNote Creator or the Markdown parser.

Dependencies
-----------------
* You need to have Markdown.pl installed on your system.

Changelog
--------------

### 0.1.2
* Added the "Writing the presentation" part of this document.

### 0.1.1
* Added this README file.

### 0.1
* The first working version.

[1]: http://daringfireball.net/projects/markdown/license
[2]: https://github.com/mrhenko/WebbNote
[3]: http://henrikcarlsson.se
[4]: http://daringfireball.net