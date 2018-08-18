################
from base-alpine

ENV TASKDDATA /tasks

RUN apk --no-cache upgrade && apk --no-cache add taskd taskd-pki && sed -i -e 's/bash/sh/' /usr/bin/taskdctl

VOLUME ["/tasks"]
workdir /tasks

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 53589

ONBUILD COPY fs /
