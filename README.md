# stackdump-lowram
bash+nodejs scripts to use stackdump with low amounts of ram, to import stackoverflow.

The nodejs scripts require event-stream, which is installed with the first line of the script.

The bash script only require built-in bash tools: grep, tee, cut, head, tail and sort.

I wasn't able to do everything with bash, but i'm sure it would be possible. Pull requests are welcome!

# WHY???

because i want stackoverflow offline, and i don't have 64 gb of ram. simple.

# WHY???

stackdump isn't optimized. 

# How to use

First, make sure your stackdump is up-to-date. My version (https://github.com/RubenNL/stackdump) worked fine in januari 2020.

This script requires a bit more than double the size of the Posts.xml file, so if you are limited on storage, only download this file at the beginning.

place the Posts.xml file in the stackdump-lowram folder.

Run the start.sh file with bash.

If you have to stop before its finished, check the last "step" number. remove all code before that line, and run again.

If i have done everything correct, you will end up with a single XML file, the Posts.xml file. this is a lot smaller than the original. Mine orginal was  the new one was around 40.05 million lines.

# How to import into stackdump

start the stackdump solr server with

bash start_solr.sh

make sure you run this in a second terminal.

Before starting the import, the site info has to be loaded.

bash manage.sh download_site_info

Download the other required files(Comments.xml, Users.xml), and start the import with the command

bash manage.sh import_site . -u stackoverflow.com -c 2019-12-02

(edit where needed)

# How long does it take?

On my hardware(spinning disk, laptop from 2009) the script took around 10 hours. stackdump import took a bit less than 3 days. My hardware was limited by the disk speed the full time.

