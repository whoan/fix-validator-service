FROM whoan/fix-validator:buster-slim as fix-validator

FROM whoan/servify:buster-slim as servify

FROM debian:buster-slim

COPY --from=fix-validator /usr/lib/libquickfix.so* /usr/lib/
COPY --from=fix-validator /usr/bin/fix-validator /usr/bin

COPY --from=servify /usr/bin/servify /usr/bin/servify

ENTRYPOINT servify --method=POST --base64 fix-validator
