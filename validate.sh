#!/usr/bin/env bash

validate_schema() {
  if ! [[ $(file "$1") =~ XML ]]; then
    echo "Schema should be an XML" >&2
    return 1
  fi

  if ! xmllint --noout "$1"; then
    return 1
  fi

  fix-validator "$@"
}

validate_schema "$@"
