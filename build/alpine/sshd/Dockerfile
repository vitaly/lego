###################
FROM alpine AS sshd

RUN apk --no-cache upgrade
RUN apk --no-cache add openssh

# SSHD CONFIG
RUN echo PermitRootLogin prohibit-password >> /etc/ssh/sshd_config
RUN echo PasswordAuthentication no >> /etc/ssh/sshd_config
RUN echo PubkeyAcceptedKeyTypes=+ssh-dss >> /etc/ssh/sshd_config

# PREPARE ROOT USER
WORKDIR /root
RUN mkdir .ssh && chmod 0700 .ssh

# ENTRY
COPY entrypoint.sh /
EXPOSE 22
ENTRYPOINT ["/entrypoint.sh"]


####################
FROM sshd AS onbuild

ONBUILD ARG GATEWAY_PORTS=no
ONBUILD RUN echo GatewayPorts ${GATEWAY_PORTS} >> /etc/ssh/sshd_config

ONBUILD ARG PERMIT_USER_ENVIRONMENT=yes
ONBUILD RUN echo PermitUserEnvironment ${PERMIT_USER_ENVIRONMENT} >> /etc/ssh/sshd_config

ONBUILD COPY fs/ /

ONBUILD WORKDIR /root
ONBUILD COPY authorized_keys/root .ssh/authorized_keys
ONBUILD RUN chmod 0600 .ssh/authorized_keys
