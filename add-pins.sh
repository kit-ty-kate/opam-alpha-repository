#!/bin/sh

set -eu

if test "$#" -lt 0; then
  echo "Usage: $0"
  exit 1
fi

dir=$(dirname "$0")
cd "$dir"
unset dir

for pkg in $(opam pin list -s); do
  last_version=$(opam show -f version "$pkg" | cut -d~ -f1)
  target=packages/$pkg/$pkg.${last_version}.1~alpha-repo
  overlay=$(opam var prefix)/.opam-switch/overlay/$pkg
  repo=$(opam-ed -f "$overlay/opam" 'get url.src' | sed -E 's,^".*(/|:)([^/:]+)/([^/#]+)(\.git)?(#.*)?"$,\2/\3,')
  sources=$(opam var prefix)/.opam-switch/sources/$pkg
  commit=$(git -C "$sources" rev-parse HEAD)
  url=https://github.com/$repo/archive/$commit.tar.gz

  dir=$(mktemp -d)
  curl -fsSLo "$dir/archive" "$url"
  sha256=$(openssl sha256 "$dir/archive" | cut '-d ' -f2)
  rm -rf "$dir"
  unset dir

  mkdir -p "$target"
  opam show --raw "$pkg" | grep -v "^name: " | grep -v "^version: " > "$target/opam"
  opam-ed -i -f "$target/opam" --preserve "add-replace url.src \"$url\""
  opam-ed -i -f "$target/opam" --preserve "add-replace url.checksum \"sha256=$sha256\""
done
