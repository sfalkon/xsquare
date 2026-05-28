FROM postgres:16-alpine

RUN apk add --no-cache musl-locales build-base git postgresql16-dev curl-dev clang19 llvm19 \
    && git clone https://github.com/pramsey/pgsql-http.git /tmp/http \
    && cd /tmp/http && make && make install \
    && rm -rf /tmp/http \
    && apk del build-base git postgresql16-dev clang19 llvm19

ENV LANG=ru_RU.UTF-8 \
    LC_ALL=ru_RU.UTF-8

