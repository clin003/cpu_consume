#!/bin/bash

VERSION=0.0.1

make clean
git add .
git commit -m "v${VERSION} debug"
git tag "v$VERSION"
make gitpush


####make clean
#make docker-image
#make docker-image-apisender
#make build