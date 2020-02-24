fs=require('fs')
es=require('event-stream')
writeStream=fs.createWriteStream('questionsStartId.xml')
fs.createReadStream('positiveQuestions.xml').pipe(es.split()).pipe(es.mapSync(function(line) {
	writeStream.write('\n'+line.split('"')[1]+'\t'+line)
}))
