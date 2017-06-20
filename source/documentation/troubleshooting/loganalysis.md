# Log analysis

## Logging box

MOT service logs are aggregated on logging box. It can be accessed by ssh-ing:

```
ssh logging-1.pp.mot.aws.dvsa
```

Access to it need your public key to be present

## Types of logs

Most of the service types we use come with **access** and **application** logs. The list includes:

|Service|Access Logs file name|Application Logs file name|
|------|----------|-----------|
|**Frontend**|FRONTEND\_APACHE.log|FRONTEND\_APP.log|
| **PHP Api** | API\_APACHE.log | API\_APP.log |
| **Auth service** | API\_JAVA\_AUTHR\_HTTP.log | API_JAVA_AUTHR.log |
| **Vehicle service** | API\_JAVA\_VEHICLE\_HTTP.log | API_JAVA_VEHICLE.log |
| **MOT Test service** | API\_JAVA\_MOT\_TEST\_HTTP.log | API\_JAVA\_MOT\_TEST.log |

Each of the logs is stored in ```/srv/log``` folder in corresponding to the node-name folder

| Service | Folder name|
| :------ | :----------- | :----------- |
| **Frontend** | frontend-i-${id}.${env}.mot.aws.dvsa |
| **PHP Api** | api-i-${id}.${env}.mot.aws.dvsa |
| **Auth service** | api\_java\_authr-i-${id}.${env}.mot.aws.dvsa |
| **Vehicle service** | api\_java\_vehicle-i-${id}.${env}.mot.aws.dvsa |
| **MOT Test service** | api\_java\_mot_test-i-${id}.${env}.mot.aws.dvsa |


where env can be:

* ci
* nft
* pp
* prd
* dmapp
* acpt

and id is id of instance as in aws console.

All logs are gzipped daily. filename is as log name itself with addition of ```-yyyyMMdd.gz```, e.g. API_JAVA_MOT_TEST_HTTP.log is gzipped as API_JAVA_MOT_TEST_HTTP.log-20170407.gz on 7th of June (and contains logs from day before mostly).

## Getting content of the logs

### man

```man``` (manual) is there to help you.

```man sort``` will show how to use sort command.

### pipe / pipeline

In Unix-like computer operating systems, a pipeline is a sequence of processes chained together by their standard streams, so that the output of each process (stdout) feeds directly as input (stdin) to the next one.

### cat and zcat

```cat``` is used to print content of plain text files and ```zcat``` is used to print content of compressed plain text files.

**Code samples**

> ```cat frontend-i-0aba51fb628ac36ab.prd.mot.aws.dvsa/FRONTEND_APACHE.log```

will list content of one file


> ```cat frontend-i-*.prd.mot.aws.dvsa/FRONTEND_APACHE.log``` <br/>

will list content of all FRONTEND APACHE logs from the prd account.

> ```zcat frontend-i-*.prd.mot.aws.dvsa/FRONTEND_APACHE.log-*.gz```

will list content of all gzipped FRONTEND APACHE logs across all prd nodes (for all dates present on the box).

### wc

```wc``` (word count) will count occurances of all words passed. ```wc -l``` will  count occurances of lines only.

E.q.

> ```zcat frontend-i-0aba51fb628ac36ab.prd.mot.aws.dvsa/FRONTEND_APACHE.log-20170505.gz | wc -l```
> shows number of lines in the file (or to be exact stream passed through the pipe)

### sort

```sort``` orders the stream passed to it in alphabetic order using string comparator as a default.

Useful flags are:

```-r``` - reversed order

```-n``` - sort as number

```cat /srv/log/frontend-i-*.prd.mot.aws.dvsa/FRONTEND_APACHE.log | grep ' gran0071 '| uniq | sort```

will show activity of certain user during a day ordered by time action was taken.

It is possible to sort by more than one column:
``` ls -l | sort -k7 -k6 ```
will sort output firts by seventh column, then by sixth

### uniq

```uniq``` helps to get unique results. It does not sort the stream!. By default it outputs uniq entries only. ```-c``` flag will show number of instances of each unique entry in the stream.

Example - number of response http codes occurences.

```cat /srv/log/frontend-i-*.prd.mot.aws.dvsa/FRONTEND_APACHE.log | grep -v 'PHP (Fatal|Notice)'| awk '{ print $14; }' | sort | uniq -c```



### head

```head``` shows top n lines from a stream (default is 10), ```-n``` param specifies how many lines. It is useful to test other commands like grep, awk, etc before running on a full set of data.

```cat /srv/log/frontend-i-*.prd.mot.aws.dvsa/FRONTEND_APACHE.log | head -n 20```

### tail

```tail``` shows bottom n lines from a stream (default is 10), ```-n``` param specifies how many lines. It is useful to test other commands like grep, awk, etc before running on a full set of data.

```cat /srv/log/frontend-i-*.prd.mot.aws.dvsa/FRONTEND_APACHE.log | tail -n 20```

### sed

```sed``` is used to replace occurrences of certain regex searches (including groups) with something else.

The following will replace a token in [A-Z0-9]{8}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{12} format into a ${token} string value (which is useful for counting purposes).

```cat /srv/log/frontend-i-*.prd.mot.aws.dvsa/FRONTEND_APACHE.log | sed 's/\/[A-Z0-9]\{8\}\-[A-Z0-9]\{4\}\-[A-Z0-9]\{4\}\-[A-Z0-9]\{4\}\-[A-Z0-9]\{12\}/\/${token}/g'```

Regexp groups need to be caught like \(\) and referenced by the number, e.g.

```cat /srv/log/frontend-i-*.prd.mot.aws.dvsa/FRONTEND_APACHE.log | sed 's/\(start-test-confirmation\/\)[^\/]\+\(\/.*$\)/\1${confirmation_token}\2/g'```

### grep

```grep``` is used to find lines matching certain criteria. It uses regex. A quick how to on default regex it uses:

| What | How it works |
| :------| :-----------|
|^ (Caret)        |    match expression at the start of a line, as in ^A. |
|$ (Question)     |    match expression at the end of a line, as in A$. |
|\\ (Back Slash)   |    turn off the special meaning of the next character, as in \\^.|
|\[ \] (Brackets)|match any one of the enclosed characters, as in [aeiou]. Use Hyphen "-" for a range, as in [0-9]. |
|[^ ]             |    match any one character except those enclosed in [ ], as in [^0-9]. |
|. (Period)       |    match a single character of any value, except end of line. |
|* (Asterisk)     |    match zero or more of the preceding character or expression. |
|\\{x,y\\}          |    match x to y occurrences of the preceding. |
|\\{x\\}            |    match exactly x occurrences of the preceding. |
|\\{x,\\}           |    match x or more occurrences of the preceding. |
|word\\&#124;word2     |    match **word** or **word2 ** |

* ```-v``` flag will list lines not matching the regexp
* ```-o``` will print only match of regex (not the whole line)
* ```--color``` will add color to the output (what was matched)
* ```-A``` - will print lines after match was found (e.g. ```grep 'test' -A 2 filename``` will print lines matching 'test' with 2 consecutive lines after it)
* ```-B``` - will print lines before match was found

### find

```find``` is used to search for files / folders matching certain criteria. E.g.

```find . -name "*.php" -O2 -type f```

will look for php files (type f means file, name anding with php) in current folder (.) with max depth of 2.
*limiting depth is implemented differently on various systems (eg. -d 1 vs -maxdepth 1), check with man*

other useful switches:
* ```-mtime``` : eg.:
  ```-mtime +1d``` - older then 1 day
  ```-mtime -1h``` - younger then 1 hour
* ```-ls``` : will list files with details
* ```-size -1k``` - smaller than 1kb

### xargs

```xargs``` is used to pass output of one command as parametrs to the other one. Fond + grep is a fine example, e.g.

```find . -name "*.php" -type f | xargs grep 'getServiceLocator()'```

will look for all php files in directory (including subdirectories) and for all the files will look for instances of ```getServiceLocator```.

### tee

```tee``` is used to pass the stream both to stdout and a file.

```
cat /srv/log/frontend-i-*.prd.mot.aws.dvsa/FRONTEND_APACHE.log | grep 'POST /login ' | awk '{ counter += 1; sum += $17 / 1000000} END {printf ("%.4lf s", sum / counter)} | tee log.txt'
```

### awk

```awk``` deserves a separate subject as it is an interpreted language [link](http://www.grymoire.com/Unix/Awk.html). It can be used as addition to other tools or can be the only tool used if someone wants to.

#### Access logs tokens

```
Jun 13 07:49:36 frontend-i-0ec28ecd32ab9d248.prd.mot.aws.dvsa FRONTEND_APACHE 10.84.112.191 - gran0071 [13/Jun/2017:07:49:31 +0000] "GET /logout HTTP/1.0" 303 - "https://www.mot-testing.service.gov.uk/" 48155
```

* $1 = Jun   // month
* $2 = 13    // day
* $3 = 07:49:36  // time
* $4 = frontend-i-0ec28ecd32ab9d248.prd.mot.aws.dvsa // node
* $5 = FRONTEND_APACHE  // node type
* $6 = 10.84.112.191 // client's ip
* $7 = -
* $8 = gran0071 user
* $9 = [13/Jun/2017:07:49:31 // date time
* $10 = +0000] // offset
* $11 = "GET // verb
* $12 = /logout // url
* $13 = HTTP/1.0" // http version
* $14 = 303 // HTTP Status
* $15 = -
* $16 = "https://www.mot-testing.service.gov.uk/" // referrer
* $17 = 48155 // time it took in microseconds

#### Printing

Awk supprts print with concatenation, e.g.

```print $1" "$2;```

a default print (no params) will print the whole line passed in a stream: ```print;```

Printf is more powerful (with ability to set widths, etc) - similar to [C/C++ one](http://www.cplusplus.com/reference/cstdio/printf/) - remember to add ```\n``` at the end :)

#### Example of use

Avg time login action takes in seconds:

```
cat /srv/log/frontend-i-*.prd.mot.aws.dvsa/FRONTEND_APACHE.log | grep 'POST /login ' | awk '{ counter += 1; sum += $17 / 1000000} END {printf ("%.4lf s", sum / counter)}'
```

## Scripts

on logging box there is a script ```/root/error_logs.sh``` which lists 5xx errors on frontend, api, auth-r, vehicle nad mot-test service (with time & count distributions).

```
#!/bin/sh

function printErrorLogs {
	nodetype=$1; nodetype_upper=`echo "${nodetype^^}"`; access_log_suffix=${2:-HTTP}; day=$(date +%d); if [[ $day == 0* ]]; then day=" "$(date +%-d); fi; date=$(date +%b)" $day"; cat /srv/log/$nodetype-i-*.prd.mot.aws.dvsa/${nodetype_upper}_${access_log_suffix}.log | grep "$date .*HTTP/1\.[0-1]\" 5" | uniq | sed "s/\($date [0-9]\{2\}\).*\(GET\|POST\|PUT\|DELETE\) \([^ ?]*\).*/\1:XX:XX \2 \3/g" | sed 's/\/[a-z0-9]\{64\}$//g' | sed 's/\(start-test-confirmation\/\)[^\/]\+\(\/.*$\)/\1${confirmation_token}\2/g' | sed 's/\(refuse-to-test\/\)\([A-Z][A-Z]\/\)\(.*\/print$\)/\1\2${refuse_to_test_token}/g'| sed 's/\/[A-Z0-9]\{8\}\-[A-Z0-9]\{4\}\-[A-Z0-9]\{4\}\-[A-Z0-9]\{4\}\-[A-Z0-9]\{12\}/\/${token}/g'|awk '{withoutIds = gensub(/(\/[0-9]+)/, "/${id}", "g", $5); print $1" "$2" "$3" "$4" "withoutIds}' | sort | uniq -c | tee /tmp/logs
}

function printErrorLogsStats {
    printf "\x1B[32m\n====> Grouped by time and error type:\n\n\x1B[36m"
    printErrorLogs $1 $2 | awk '{ printf("%6d: %s %s %s %s %s\n", $1, $2, $3, $4, $5, $6) }' | tee /tmp/error_logs_stats

    error_lines=`wc -l /tmp/error_logs_stats | awk {'print $1'}`
    if [ "$error_lines" == "0" ]; then
	echo "No 5xx errors :)"
    else
	printf "\x1B[32m\n====> Grouped by error type:\n\n\x1B[36m"
    	cat /tmp/logs |  awk '{counter[$5" "$6] += $1; } END { for (key in counter) printf("%6d: %s\n", counter[key], key) }' | sort -r -n
    fi
}

function printErrorLogsStatsApache {
    printErrorLogsStats $1 APACHE
}

printf "\x1B[33m======\nFRONTEND\n======\n"
printErrorLogsStatsApache frontend
printf "\x1B[33m\n======\nAPI\n======\n"
printErrorLogsStatsApache api
printf "\x1B[33m\n======\nAuth-r\n======\n"
printErrorLogsStats api_java_authr
printf "\x1B[33m\n======\nMOT Test\n======\n"
printErrorLogsStats api_java_mot_test
printf "\x1B[33m\n======\nVehicle\n======\n"
printErrorLogsStats api_java_vehicle
```
