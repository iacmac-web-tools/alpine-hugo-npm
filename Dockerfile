FROM alpine:3.11

ARG HUGO_VERSION=0.59.1
ARG HUGO_DOWNLOAD_URL="https://github.com/gohugoio/hugo/releases/download/v$HUGO_VERSION/hugo_extended_"$HUGO_VERSION"_Linux-64bit.tar.gz"
ARG HUGO_DOWNLOAD_FILE_NAME=hugo.tar.gz
ENV HUGO_USER=hugo \
    HUGO_UID=1000 \
    HUGO_GID=1000 \
    HUGO_HOME=/hugo

RUN addgroup -S $HUGO_USER -g ${HUGO_GID} \
    && adduser -S  \
    -g $HUGO_USER \
    -h $HUGO_HOME \
    -u ${HUGO_UID} \
    $HUGO_USER

RUN apk add --no-cache  git curl tar \
    &&  apk add --update nodejs npm \
    &&  curl -L "$HUGO_DOWNLOAD_URL" -o "$HUGO_DOWNLOAD_FILE_NAME" \
    &&  tar xvz -C /tmp  -f "$HUGO_DOWNLOAD_FILE_NAME"  \
    &&  mv /tmp/hugo /usr/local/bin/hugo \
    &&  apk del curl tar \
    &&  rm -rf /tmp/* \
    &&  rm -rf /var/cache/apk/*
