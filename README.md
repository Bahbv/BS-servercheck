servercheck
========

Bash script for checking a websites availability and reporting in Slack

## Config
Fill websites.lst with the website URL on each newline, leave an empty line at the end of the file.

!Note that the script will follow urls with a 301 redirect.

## Add to crontab
Add the following line to the cronjob

```
*/30 * * * * /path/to/checker.sh
```

or

```
*/30 * * * * /bin/bash /path/to/checker.sh
```

in this example crontab will run ```checker.sh``` every 30 minutes.


[Bob Vrijland]: <bob@bahbv.net>
