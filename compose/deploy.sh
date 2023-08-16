#! /bin/bash

set -e # exit on error
set -x # print commands

VERSION=0.0.0

docker save -o prog-tt-web-V$VERSION prog-tt-web:$VERSION
docker save -o prog-tt-gql-V$VERSION prog-tt-gql:$VERSION

REMOTE=kpetrucena@kpetrucena.lv
scp ./prog-tt-web-V$VERSION $REMOTE:~
scp ./prog-tt-gql-V$VERSION $REMOTE:~