#!/bin/bash
grep -F 'PostTypeId="1"' Posts.xml | grep -Fv 'AnswerCount="0"' | awk '{split($0,a,"\""); print a[2] $0}'>combinedNotSorted.xml
grep -F 'PostTypeId="2"' Posts.xml | awk '{split($0,a,"\""); print a[6] $0}' >> combinedNotSorted.xml
mv Posts.xml Posts.xml-old
head -n2 Posts.xml-old > Posts.xml
tail -n1 Posts.xml-old > lastLine.xml
rm Posts.xml-old
sort --parallel=2 -k 1n -n combinedNotSorted.xml | cut -f2- >> Posts.xml
rm combinedNotSorted.xml
cat lastLine.xml >> Posts.xml
rm lastLine.xml
