#!/bin/bash

mkdir -p $MOUNTDIR
mkdir -p /tmp

echo BUCKETNAME: $BUCKETNAME
echo MOUNTDIR: $MOUNTDIR

s3fs $BUCKETNAME $MOUNTDIR \
    -o use_cache=/tmp \
    -o allow_other \
    -o umask=0002 \
    -o use_rrs

## Your startup scripts
node server.js