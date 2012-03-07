#!/bin/bash

# start the release

if [[ $# -lt 1 ]]; then
  echo "usage: $(basename $0) new-version" >&2
  exit 1
fi

version=$1

echo ""
echo "Start release of $version, previous version is $previous_version"
echo ""
echo ""

git flow release start $version || exit 1

echo -n "Peform release.  enter to continue:" && read x \
&& mvn release:clean \
&& mvn release:prepare \
&& mvn release:perform \
&& mvn nexus:staging-close \
&& mvn nexus:staging-promote \
&& git flow release finish -n $version
