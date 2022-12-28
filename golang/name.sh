#! /usr/bin/env bash

NEWNAME=""

if [ $# -ne 1 ]; then
  echo "enter exactly one name"
  exit 1
else
  NEWNAME=$1
fi

sed -i "s|this-project|$NEWNAME|" go.mod flake.nix

mv cmd/this-project cmd/$NEWNAME

