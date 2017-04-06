if [ ! -f /etc/configured ]; then
   GW_HOST=`cat /etc/hostname | xargs echo -n`
   grunt config -set=client.Connection.RedirectIDM --value=http://$GW_HOST.local:3000/oauth2/dialog/authorize/
   grunt
   echo "var $GW_HOST"
   echo "var $GW_HOST"
   touch /etc/configured
fi

./bin/start-dev.sh

