#!/bin/bash

if [ ! -f /etc/configured ]; then
   GW_HOST=${AGILE_HOST:-`cat /etc/hostname | xargs echo -n`.local}
   if [ "$AGILE_SSL" == "1" ]
   then
       PROTO="https"
       PORT=1444
   else
      PROTO="http"
      PORT=3000
   fi
   grunt config -set=client.Connection.RedirectIDM --value=$PROTO://$GW_HOST:$PORT/oauth2/dialog/authorize/
   grunt
   echo "value for AGILE_SSL $AGILE_SSL"
   echo "OS-JS configured to use IDM at: $PROTO://$GW_HOST:$PORT/oauth2/dialog/authorize/"
   echo "var $GW_HOST"
   touch /etc/configured
fi

./bin/start-dev.sh
