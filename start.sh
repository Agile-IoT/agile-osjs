#-------------------------------------------------------------------------------
# Copyright (C) 2017 Create-Net / FBK.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
# 
# Contributors:
#     Create-Net / FBK - initial API and implementation
#-------------------------------------------------------------------------------

if [ ! -f /etc/configured ]; then
   GW_HOST=${AGILE_HOST:-`cat /etc/hostname | xargs echo -n`.local}
   grunt config -set=client.Connection.RedirectIDM --value=http://$GW_HOST:3000/oauth2/dialog/authorize/
   grunt
   echo "var $GW_HOST"
   echo "var $GW_HOST"
   touch /etc/configured
fi

./bin/start-dev.sh

