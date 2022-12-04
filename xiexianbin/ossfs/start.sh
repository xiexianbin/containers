#!/bin/bash

echo ${BUCKETNAME}:${ACCESSKEYID}:${ACCESSKEYSECRET} > /etc/passwd-ossfs
chmod 640 /etc/passwd-ossfs
mkdir /var/local/ossfs

PARMS=""
if [[ "${NONEMPTY}"x == "1"x ]]; then
    PARMS="nonempty"
fi

ossfs ${BUCKETNAME} /var/local/ossfs -ourl=${OSS_ENDPOINT} ${PARMS}

