FROM little78926/debian-nodejs-s3fs

ARG local="."

WORKDIR /application
RUN mkdir -p /application

COPY $local/src/package.json /application
RUN npm i

COPY $local/src /application

RUN chmod +x /application/run.sh

ENTRYPOINT ["/application/run.sh"]