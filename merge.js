var fs = require('fs');

var args = process.argv.splice(2);
if (args.length < 2) {
    console.log("You must pass two file names to merge two files");
    console.log("Usage:", process.argv[0], " file1 file2");
    process.exit(0);
}
var mergeInto = args[0]
var mergeFrom = args[1]

//set or get rules
function srules(sarif, optional_set) {
    if (optional_set) { sarif.runs[0].tool.driver.rules = optional_set }
    return sarif.runs[0].tool.driver.rules
}
function sresults(sarif, optional_set) {
    if (optional_set) { sarif.runs[0].results = optional_set }
    return sarif.runs[0].results
}

function mergeSarif(d1, d2) {
    var j1 = JSON.parse(d1)
    var j2 = JSON.parse(d2)
    console.log(mergeInto + " rules found: ", srules(j1).length)
    console.log(mergeInto + " locations found: ", sresults(j1).length)
    console.log(mergeFrom + " rules found: ", srules(j2).length)
    console.log(mergeInto + " locations found: ", sresults(j2).length)

    var combined = srules(j1).concat(srules(j2));
    var included = new Set()
    var newRules = []
    combined.forEach(function (e) {
        if (!included.has(e.id)) {
            included.add(e.id);
            newRules.push(e)
        }
    })
    console.log("Number of rules combined is: ", newRules.length)
    srules(j1, newRules);
    var c = 0;
    newRules.forEach(function (e) {
        console.log(c++, ':', e.id)
    })
    sresults(j1, sresults(j1).concat(sresults(j2)))
    console.log("Number of source locations combined is: ", sresults(j1).length)
    c = 0;
    sresults(j1).forEach(function (e) {
        console.log(c++, ':', e.ruleId)
    })
    return j1;
}

fs.readFile(mergeInto, 'utf8', function (err, mergeIntodata) {
    fs.readFile(mergeFrom, 'utf8', function (err, mergeFromdata) {
        var merged = mergeSarif(mergeIntodata, mergeFromdata)
        writeJSON(mergeInto, merged, process.exit)
    })
})

function writeJSON(file, value, then) {
    var stream = fs.createWriteStream(file);
    stream.once('open', function (fd) {
        stream.write(JSON.stringify(value));
        stream.end();
        console.log("Created: ", file);
        then(0)
    });
}