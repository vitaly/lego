####################################
ARG HUB_USER
FROM ${HUB_USER}/sshd-alpine AS gitd

# DISABLE LOGIN BANNERS
RUN touch .hushlogin
RUN rm -f /etc/update-motd.d /etc/motd /etc/motd.dynamic

# GIT USER
RUN apk add --no-cache git shadow
RUN groupadd -g 1000 -r git
RUN useradd -d /git -m -u 1000 -g git -s /usr/bin/git-shell git
RUN usermod -p '*' git
WORKDIR /git
COPY git-shell-commands git-shell-commands
RUN chown -R git:git .


####################
FROM gitd AS onbuild

ONBUILD ARG GATEWAY_PORTS=no
ONBUILD RUN echo GatewayPorts ${GATEWAY_PORTS} >> /etc/ssh/sshd_config

ONBUILD ARG PERMIT_USER_ENVIRONMENT=yes
ONBUILD RUN echo PermitUserEnvironment ${PERMIT_USER_ENVIRONMENT} >> /etc/ssh/sshd_config

ONBUILD COPY ssh/ /etc/ssh/

# ROOT AUTH
ONBUILD WORKDIR /root
ONBUILD COPY authorized_keys/root .ssh/authorized_keys
ONBUILD RUN chmod 0600 .ssh/authorized_keys

# GIT AUTH
ONBUILD WORKDIR /git
ONBUILD COPY authorized_keys/git .ssh/authorized_keys
ONBUILD RUN chown git .ssh/authorized_keys && chmod 0600 .ssh/authorized_keys

# GIT ENVIRONMENT
ONBUILD ARG GIT_ROOT=git
ONBUILD RUN echo GIT_ROOT=${GIT_ROOT} > .ssh/environment && chown git:git .ssh/environment
ONBUILD RUN chown -R git:git .
