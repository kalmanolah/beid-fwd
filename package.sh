#!/bin/bash

BEID_FWD_VERSION="0.0.1"

cd "$(dirname "$0")"

mkdir -p build
mkdir -p build/usr/local/etc
mkdir -p build/usr/local/bin
mkdir -p build/usr/local/share/beid-fwd
mkdir -p build/usr/lib/systemd/system


cp beid-fwd.cfg build/usr/local/etc/
cp beid-fwd.sh build/usr/local/bin/
cp beid-cli.jar build/usr/local/share/beid-fwd/
cp beid-fwd.service build/usr/lib/systemd/system/

for TARGET in rpm deb
do
    fpm -f -s dir -t $TARGET \
        --name "beid-fwd" \
        --version "$BEID_FWD_VERSION" \
        --iteration "1" \
        --architecture noarch \
        --prefix / \
        --vendor "Inuits" \
        --description "BeID CLI + BeID Forwarder" \
        --maintainer "Kalman Olah <kalman@inuits.eu>" \
        --exclude "rpmbuild" \
        --epoch "1" \
        --rpm-auto-add-directories \
        --url "https://github.com/kalmanolah/beid-fwd" \
        -C ./build .
done
