fs=require('fs')
es=require('event-stream')
function binary_search_iterative(a, value) {
	var lo = 0, hi = a.length - 1, mid;
	while (lo <= hi) {
		mid = Math.floor((lo+hi)/2);
		if (a[mid] > value)
			hi = mid - 1;
		else if (a[mid] < value)
			lo = mid + 1;
		else
			return mid;
	}
	return null;
}
list=fs.readFileSync('deleteQuestions.ids','utf8').split('\n').sort()
writeStream=fs.createWriteStream('answersWithoutDeletedQuestions.xml')
fs.createReadStream('answers.xml').pipe(es.split()).pipe(es.mapSync(function(line) {
	id=line.split('"')[5]
	if(binary_search_iterative(list,id)) return
	writeStream.write('\n'+id+'-\t'+line)
}))
