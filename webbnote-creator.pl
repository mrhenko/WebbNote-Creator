#!/usr/bin/perl

#
# WebbNote Creator - A text to WebbNote compatible HTML5
# that uses John Gruber's Markdown for syntax.
#
# Neither I nor the product WebbNote or WebbNote Creator
# is in anyway affiliated with and/or endorsed by
# John Gruber.
#
# Copyright (c) 2011 Henrik Carlsson
# <…>
#
# Version 0.1.1
#

# Define global variables
# (Prefix every variable with wn_
$wn_default_markup;
$wn_markdown_file;
$wm_markdown_file_name;

# Get the name of the markdown file that is supposed to
# be processed
@args = @ARGV;
$wn_markdown_file_name = $args[-1];

# Load the template
#open TEMPLATE, 'lib/template.htm' or die 'I\'m sorry, I couldn\'t load the template';
#$wn_default_markup = join('', <TEMPLATE>);
#close TEMPLATE;
$wn_default_markup = '<!DOCTYPE html>
<html class="dev">
<head>
    <meta charset="UTF-8" />
    <title>WebbNote: Proof of Concept</title>
    <link rel="stylesheet" href="webbnote/core.css" media="screen" />
    <link rel=”stylesheet” href="webbnote/default_theme.css" media="screen" />
    <link rel=”stylesheet” href="webbnote/print.css" />
</head>
<body>
	<article id="keynote">
		[presentation]
	</article>
	
	<script src="webbnote/jquery-1.4.4.min.js"></script>
	<script src="webbnote/webbnote.js"></script>
	<script>
	    var files = new Array(\'mysound.mp3\', \'mysound.ogg\');
    	init_webbnote(files);
</script>
</body>
</html>';

# Load the Markdown file
open PRES, $wn_markdown_file_name or die 'I\'m sorry. That Markdown file could not be found';
$wn_markdown_file = join('', <PRES>);
close PRES;


# Create a temp file that can be piped to Markdown
open (TEMP, '>>wn_temp');
print TEMP $wn_markdown_file;
close TEMP;

# Markdown
$wn_markdown_file = `markdown.pl wn_temp`;

# Remove the temp
`rm wn_temp`;

# Process
# Turn the Markdown for horizontal lines into
# new presetational slides
# (The Regex is based on its equivalent in the Markdown source.
$wn_markdown_file = '<section class="page">' . $wn_markdown_file . '</section>';
$rp = "</section><section class=\"page\">";
$wn_markdown_file =~ s/\s*\[newslide\]\s*/$rp/g;
#$wn_markdown_file =~ s{^[ ]{0,2}([ ]?\*[ ]?){3,}[ \t]*$}{$rp}gmx;
#$wn_markdown_file =~ s{^[ ]{0,2}([ ]? -[ ]?){3,}[ \t]*$}{$rp}gmx;
#$wn_markdown_file =~ s{^[ ]{0,2}([ ]? _[ ]?){3,}[ \t]*$}{$rp}gmx;

# Markdown adds <p> around </section> and <section>
# Do something about it
$wn_markdown_file =~ s/<p><\/section><section class="page"><\/p>/<\/section>\n\n<section class="page">/g;

# Insert the former Markdown (now HTML) on its correct
# place in the template-
$wn_new_file = $wn_default_markup;
$wn_new_file =~ s/\[presentation\]/$wn_markdown_file/g;

# Now, create a new file with the WebbNote
open (WEBBNOTE, '>>index.htm');
print WEBBNOTE $wn_new_file;
close WEBBNOTE;