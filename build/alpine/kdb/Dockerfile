FROM base-alpine

RUN apk add --no-cache curl binutils \
  && LIBC32_DEB=libc6-i386_2.19-18+deb8u10_amd64.deb \
  && wget "http://ftp.us.debian.org/debian/pool/main/g/glibc/$LIBC32_DEB" \
  && echo "aeee7bebb8e957e299c93c884aba4fa9  $LIBC32_DEB" | md5sum -c - \
  && ar p $LIBC32_DEB data.tar.xz | unxz | tar -x \
  && rm -rf $LIBC32_DEB /usr/share/doc/libc6-i386 /usr/lib32/gconv /usr/share/lintian \
  && apk del binutils

RUN \
      curl --silent -O https://kx.com/347_d0szre-fr8917_llrsT4Yle-5839sdX/3.5/linuxx86.zip && \
      unzip linuxx86.zip && \
      rm linuxx86.zip

ENV QHOME /q
ENV PATH ${PATH}:${QHOME}/l32/

WORKDIR /work

CMD q
