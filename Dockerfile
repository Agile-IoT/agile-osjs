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

ARG BASEIMAGE_BUILD=resin/raspberry-pi3-node:7.8.0-20170426

FROM $BASEIMAGE_BUILD

## Clone the  Repo and install grunt ##
COPY OS.js OS.js
RUN npm install -g grunt-cli supervisor

## Install and build OS.js ##
WORKDIR OS.js/
RUN npm install --production

## Install IDM menu item
COPY agile-idm-osjs agile-idm-osjs
RUN agile-idm-osjs/agile-osjs-install.sh agile-idm-osjs
#RUN grunt

## Install Node red menu item
COPY osjs-nodered src/packages/default/NodeRed
RUN grunt manifest config packages:default/NodeRed

## Install Node red Dashboard
COPY agile-nodered-dashboard-osjs src/packages/default/NodeRedDashboard
RUN grunt manifest config packages:default/NodeRedDashboard

## Install Node red Graphs
COPY agile-contri-ui-osjs src/packages/default/NodeRedUI
RUN grunt manifest config packages:default/NodeRedUI

## Install Agile Device Manager
COPY agile-osjs-devicemanager src/packages/default/DeviceManager
RUN grunt manifest config packages:default/DeviceManager

## Start Application and Expose Port ##
## Note: you can change 'start-dev.sh' (Development Version) to 'start-dist.sh' (Production Version) ##

EXPOSE 8000:8000

#CMD ./bin/start-dev.sh
COPY ./start.sh  ./
CMD ./start.sh
