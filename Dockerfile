FROM node:12.14.0-alpine3.9

ENV HUGO_VERSION=0.59.1
ENV HUGO_BINARY=hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz
ENV HUGO_DOWNLOAD_URL=https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY}
ENV GLIBC_VERSION=2.27-r0

RUN set -ex \
    && apk add --no-cache  git curl tar \
    && apk add --update wget ca-certificates libstdc++ \
    &&  wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
    &&  wget "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC_VERSION/glibc-$GLIBC_VERSION.apk" \
    &&  apk --no-cache add "glibc-$GLIBC_VERSION.apk" \
    &&  rm "glibc-$GLIBC_VERSION.apk" \
    &&  wget "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC_VERSION/glibc-bin-$GLIBC_VERSION.apk" \
    &&  apk --no-cache add "glibc-bin-$GLIBC_VERSION.apk" \
    &&  rm "glibc-bin-$GLIBC_VERSION.apk" \
    &&  wget "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC_VERSION/glibc-i18n-$GLIBC_VERSION.apk" \
    &&  apk --no-cache add "glibc-i18n-$GLIBC_VERSION.apk" \
    &&  rm "glibc-i18n-$GLIBC_VERSION.apk" \
    &&  wget ${HUGO_DOWNLOAD_URL} \
    &&  tar xzf ${HUGO_BINARY} \
    &&  rm -r ${HUGO_BINARY} \
    &&  mv hugo /usr/bin \
    &&  apk del wget ca-certificates \
    &&  rm /var/cache/apk/* \
    &&  npm install -D --save postcss-cli
    && hugo version && npm version

    
