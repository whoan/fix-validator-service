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

errors=$(validate_schema "$@" 2>&1)
echo -n $errors | sed "s_$1:__g" >&2

[ -z "$errors" ]
