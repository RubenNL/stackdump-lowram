#!/bin/bash
mv Posts.xml Posts.xml-old
head -n2 Posts.xml-old > Posts.xml
(grep -F 'PostTypeId="1"' Posts.xml-old | grep -Fv 'AnswerCount="0"' | awk '{split($0,a,"\""); print a[2]"\t"$0}'; grep -F 'PostTypeId="2"' Posts.xml-old | awk '{split($0,a,"\""); print a[6]"\t"$0}') | sort --parallel=2 -k 1n -n | cut -f2- >> Posts.xml
tail -n1 Posts.xml-old >> Posts.xml
rm Posts.xml-old