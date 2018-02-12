#!/bin/bash
APPS='/opt/osjs-apps'

for x in "$(ls  $APPS)"; do
  echo "installing app $x"
  cp -r $APPS/$x src/packages/default/$x
  grunt manifest config packages:default/$x
done
grunt
