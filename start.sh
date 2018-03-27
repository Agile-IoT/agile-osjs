#!/bin/bash
#-------------------------------------------------------------------------------
# Copyright (C) 2017 Create-Net / FBK.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License 2.0
# which accompanies this distribution, and is available at
# https://www.eclipse.org/legal/epl-2.0/
#
# Contributors:
#     Create-Net / FBK - initial API and implementation
#-------------------------------------------------------------------------------

HOST=`cat /etc/configured`
GW_HOST=${AGILE_HOST:-`cat /etc/hostname | xargs echo -n`.local}

if [ "$GW_HOST" != "$HOST" ]
then
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
   echo "$GW_HOST">/etc/configured
fi


./bin/start-dev.sh
