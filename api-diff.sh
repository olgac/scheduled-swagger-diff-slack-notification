#!/bin/bash

ROOT_PATH=$(dirname "$0")
if [ ! -f $ROOT_PATH/environment.list ]; then
        echo "$ROOT_PATH/environment.list File not found!"
        exit 0
fi

echo "$(date) STARTED"
NOW=$(date +%Y%m%d_%H%M%S)

SLACK_URL=https://hooks.slack.com/services/SOME-KEYS/FOR-YOUR/SLACK-CHANNEL

for LINE in $(cat $ROOT_PATH/environment.list); do
        ACTIVE=$( echo $LINE | cut -d';' -f1 )
        NAME=$(   echo $LINE | cut -d';' -f2 )
        ENV=$(    echo $LINE | cut -d';' -f3 )
        URL=$(    echo $LINE | cut -d';' -f4 )

        if [ $ACTIVE == 1 ]; then
                CURRENT_PATH=$ROOT_PATH/outputs/$NAME
                mkdir -p $CURRENT_PATH
                if [ ! -f $CURRENT_PATH/$ENV.latest.json ]; then
                        curl -s -H 'Cache-Control: no-cache' $URL > $CURRENT_PATH/$ENV.latest.json
                fi

                curl -s -H 'Cache-Control: no-cache' $URL > $CURRENT_PATH/$ENV.current.json
                if [[ -f $CURRENT_PATH/$ENV.latest.json && -f $CURRENT_PATH/$ENV.current.json ]]; then
                        /usr/local/bin/swagger-diff -c $CURRENT_PATH/$ENV.latest.json $CURRENT_PATH/$ENV.current.json > $CURRENT_PATH/$ENV.$NOW.diff 2>/dev/null

                        if [ -f $CURRENT_PATH/$ENV.$NOW.diff ]; then
                                if [[ $(tr -d "\r\n" < $CURRENT_PATH/$ENV.$NOW.diff | wc -c) -gt 0 ]]; then
                                        curl -s -X POST --data "payload={\"text\": \"API-DIFF NOTIFICATION\nProject: $NAME\n Environmet: $ENV\n$(cat $CURRENT_PATH/$ENV.$NOW.diff)\"}" $SLACK_URL
                                        gzip -f $CURRENT_PATH/$ENV.$NOW.diff
                                else
                                        rm -f $CURRENT_PATH/$ENV.$NOW.diff
                                fi
                        fi
                fi
                mv -f $CURRENT_PATH/$ENV.current.json $CURRENT_PATH/$ENV.latest.json
        fi
done

echo "$(date) FINISHED"