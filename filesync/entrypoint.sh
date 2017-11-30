#!/bin/sh

if [ $LAGOONSYNC_ROLE = "master" ]; then
  echo "role is master; connecting to ${LAGOONSYNC_DEST}."
  SSH_ARGS="-p ${LAGOONSYNC_PORT}"

  touch /root/.ssh/config
  echo "Host ${LAGOONSYNC_DEST}" >> /root/.ssh/config
  echo "   Port ${LAGOONSYNC_PORT}" >> /root/.ssh/config
  echo "   IdentityFile /root/.ssh/id_rsa" >> /root/.ssh/config

  # /nss-wrap.sh ssh-keyscan -p ${LAGOONSYNC_PORT} ${LAGOONSYNC_DEST} > /home/unison/.ssh/known_hosts

  cd /app/docroot/sites/default/files/
  unison -repeat 10 /app/docroot/sites/default/files/ ssh://${LAGOONSYNC_DEST}//app/docroot/sites/default/files
  unison -repeat 10 /app/docroot/sites/default/files/ ssh://${LAGOONSYNC_DEST}//app/docroot/sites/default/files
else
  echo "role is listener;"
  exec 2>&1
  exec /usr/sbin/sshd -D -p 2200 -e
fi
