#!/bin/sh

set -e

if test "$#" -lt 1; then
  echo "Usage: $0 PACKAGE"
  exit 1
fi

while test "$#" -ge 1; do
  pkg=$1
  shift

  last_version=$(opam show -f version "$pkg" | cut -d~ -f1)
  target=$pkg/$pkg.${last_version}.1~alpha-repo

  mkdir -p "$target"
  opam show --raw "$pkg" | grep -v "^name: " | grep -v "^version: " > "$target/opam"
done
