#!/bin/bash
# Website status checker to work with slack webhook.

WORKSPACE=/scripts/servercheck
LISTFILE=$WORKSPACE/websites.lst
TEMPDIR=$WORKSPACE/cache
QUIET=true

function test {
  response=$(curl -L --write-out %{http_code} --silent --output /dev/null $1)
  filename=$( echo $1 | cut -f1 -d"/" )
  if [ "$QUIET" = false ] ; then echo -n "$p "; fi

  if [ $response -eq 200 ] || [ $response -eq 301 ] || [ $response -eq 000 ] || [ $response -eq 302 ] ; then
    # website up
    if [ "$QUIET" = false ] ; then
      echo -n "$response "; echo -e "\e[32m[ok]\e[0m"
    fi
  else
    # website down
    if [ "$QUIET" = false ] ; then echo -n "$response "; echo -e "\e[31m[DOWN]\e[0m"; fi
            STR="Het ziet er naar uit dat '$p' down is. Status code: $response $e" 
			curl -X POST --data-urlencode "payload={\"channel\": \"#server-status\", \"username\": \"statusBot\", \"text\": \" ""$STR""\", \"icon_emoji\": \":sos:\"}" https://hooks.slack.com/services/YOUR_HOOK_HERE
  fi
}

# main loop
while read p; do
  test $p
done < $LISTFILE
