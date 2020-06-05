#!/usr/bin/env perl
#
# 04.05.2020
# surfraw.cgi for w3m
# barely tested and created by Jonny Högsten aka frakswe
# (learned from w3m/Bonus/google.cgi & surfraw/examples/hooks.lua)
# source: https://pastebin.com/TUcRgu9y
#         https://www.reddit.com/r/w3m/comments/g9jqb1/w3m_prefix_search_engine_searches_via_fzf_and/
#
# example-usage: open urlinput and type for ex. "youtube:gotbletu"
# or in the commandline "w3m urban:woke".
#
# installation:
# sudo cp ./surfraw.cgi /usr/lib/w3m/cgi-bin/
# sudo chmod +x /usr/lib/w3m/cgi-bin/surfraw.cgi
#
# create file if not already existing:
# touch ~/.w3m/urimethodmap
#
# and do for ex.:
# echo 'google: file:/cgi-bin/surfraw.cgi?%s
# duckduckgo: file:/cgi-bin/surfraw.cgi?%s
# stack: file:/cgi-bin/surfraw.cgi?%s
# youtube: file:/cgi-bin/surfraw.cgi?%s
# urban: file:/cgi-bin/surfraw.cgi?%s' >>~/.w3m/urimethodmap
#
# ([elvi]: file:/cgi-bin/surfraw.cgi%s)
# w3m needs to be restarted each time you make changes in the urimethodmap file.
#
$search = $ENV{"QUERY_STRING"};
$search =~ tr/:/ /;
$url = `surfraw -p $search`;
print <<EOF;
w3m-control: GOTO $url
EOF
