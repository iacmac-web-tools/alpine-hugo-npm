FROM node:12.14.0-alpine3.9

ARG HUGO_VERSION=0.59.1
ARG HUGO_DOWNLOAD_URL="https://github.com/gohugoio/hugo/releases/download/v$HUGO_VERSION/hugo_extended_"$HUGO_VERSION"_Linux-64bit.tar.gz"
ARG HUGO_DOWNLOAD_FILE_NAME=hugo.tar.gz

RUN set -ex \
    && apk add --no-cache  git curl tar \
    && apk add --update wget ca-certificates libstdc++ \
    &&  curl -L "$HUGO_DOWNLOAD_URL" -o "$HUGO_DOWNLOAD_FILE_NAME" \
    &&  tar xvz -C /tmp  -f "$HUGO_DOWNLOAD_FILE_NAME"  \
    &&  mv /tmp/hugo /usr/local/bin/hugo \
    &&  apk del curl tar \
    &&  rm -rf /tmp/* \
    &&  rm -rf /var/cache/apk/* \
    && npm version \
    && hugo version \
