FROM docker.pkg.github.com/whoan/fix-validator/fix-validator:buster-slim as fix-validator

FROM docker.pkg.github.com/whoan/servify/servify:buster-slim as servify

FROM debian:buster-slim

RUN \
  apt-get update && \
  apt-get install --yes libxml2-utils file && \
  rm -rf /var/lib/apt/lists/*

COPY --from=fix-validator /usr/lib/libquickfix.so* /usr/lib/
COPY --from=fix-validator /usr/bin/fix-validator /usr/bin

COPY --from=servify /usr/bin/servify /usr/bin/servify

COPY validate.sh /app/validate.sh

ENTRYPOINT servify --method=POST --base64 'bash /app/validate.sh'
