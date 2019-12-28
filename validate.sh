#!/usr/bin/env bash

if fix-validator "$@"; then
  exit
fi

if [[ $(file "$1") =~ XML ]]; then
  xmllint --noout "$1"
else
  echo "Schema should be an XML" >&2
fi

exit 1
