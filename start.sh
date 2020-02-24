#!/bin/bash
npm install #installs event-stream. required for parsing huge files in nodejs
grep -F 'PostTypeId="1"' Posts.xml | grep -Fv 'AnswerCount="0"' | tee questions.xml | grep -F 'Score="-' | cut -d'"' -f2 > deleteQuestions.ids #removes all questions without answers, writes that to questions.xml. also writes all questions with negative score to deleteQuestions.ids
grep -Fv 'Score="-' questions.xml > positiveQuestions.xml #writes all positive questions to positivequestions.xml
rm questions.xml
grep -F 'PostTypeId="2"' Posts.xml > answers.xml #writes all answers to answers.xml

mv Posts.xml Posts.xml-old
head -n2 Posts.xml-old > Posts.xml #XML headers required. took me 4 days to figure this out.
tail -n1 Posts.xml-old > lastLine.xml
rm Posts.xml

node remove-downvoted-answers.js #uses deletequestions.ids and questions.xml, writes all answers to non-negative questions to answersWithoutDeletedQuestions.xml, with the id of the question at the beginning, to make sorting easier.

rm deleteQuestions.ids
node questions-number-beginning.js #uses positiveQuestions.xml, puts the id of the question at the beginning of the line, to make sorting easier. writes to questionsStartId.xml
rm positiveQuestions.xml

cat questionsStartId.xml answersWithoutDeletedQuestions.xml > combinedNotSorted.xml
rm questionsStartId.xml answersWithoutDeletedQuestions.xml

sort --parallel=2 -k 1n -n -o combinedSorted.xml combinedNotSorted.xml #sorts everything. let it do its thing, takes a couple hours.
rm combinedNotSorted.xml
cut -f2- combinedSorted.xml > Posts.xml #removes the id at the beginning
rm combinedSorted.xml
cat lastLine.xml >> Posts.xml #ads the lastline to the file
rm lastLine.xml
