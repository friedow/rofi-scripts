#!/bin/sh
set -e
set -o pipefail

function isSelectedEvent() {
  if [[ -n $@ ]]; then
    return 0
  else
    return 1
  fi
}

function listProjectDirectories() {
  local gitDirectories=$(find ~ -name .git)
  local gitDirectoriesFormatted=$(echo "$gitDirectories" | sed "s+$HOME+~+g")
  local projectDirectories=$(echo "$gitDirectoriesFormatted" | sed "s+/.git++g")
  echo "$projectDirectories"
}

if isSelectedEvent "$1"; then
  selectedProject="$1"
  selectedProjectDirectory=$(echo "$selectedProject" | sed "s+~+$HOME+g")
  coproc ( code "$selectedProjectDirectory"  > /dev/null  2>&1)
  exit
else
  listProjectDirectories | sed "s+ +\n+g"
fi
