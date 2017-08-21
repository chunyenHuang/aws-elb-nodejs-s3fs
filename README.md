# debian-nodejs-s3fs

The startup kits for AWS Elasticbeanstalk (ELB) deployment.

## Examples

- [Basic Usage](./examples/basic)
- [ELB Deployment](./examples/elb-nginx-cadvisor)

## GetStarted

```bash
docker pull little78926/debian-nodejs-s3fs
```

### Build your image

- Add your start command in the `run.sh`
- Copy `run.sh` to your image and set it as the entrypoint

#### run.sh

- Add your starup scripts at the end

```sh
#!/bin/bash

MOUNTDIR="/home/s3"

mkdir -p $MOUNTDIR
mkdir -p /tmp

echo BUCKETNAME: $BUCKETNAME
echo MOUNTDIR: $MOUNTDIR

s3fs $BUCKETNAME $MOUNTDIR \
    -o use_cache=/tmp \
    -o allow_other \
    -o umask=0002 \
    -o use_rrs

## Add your startup script here
## node server.js
## pm2-docker start process.json
```

#### Dockerfile

```dockerfile
FROM little78926/debian-nodejs-s3fs

ARG local="."

WORKDIR /application
RUN mkdir -p /application

COPY $local/src/package.json /application
RUN npm i

COPY $local/src /application

RUN chmod +x /application/run.sh

ENTRYPOINT ["/application/run.sh"]
```

### Run the container

You will need to pass the following enviroment variables

- AWSACCESSKEYID
- AWSSECRETACCESSKEY
- BUCKETNAME
- MOUNTDIR (This is the path to mount s3 inside your container)

```bash
docker run\
    --privileged \
    --cap-add SYS_ADMIN \
    --device /dev/fuse \
    -e "AWSACCESSKEYID=[]" \
    -e "AWSSECRETACCESSKEY=[]" \
    -e "BUCKETNAME=[]" \
    -e "MOUNTDIR=[]" \
    YOUR_IMAGE_NAME
```
