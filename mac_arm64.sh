#!/bin/sh

rm config.h
echo "Building for arm64 MacOS"

set -e

ARCH="arm64"

. shared_options.sh

./configure \
    --prefix=./macos/${ARCH} \
    --extra-cflags="-D__STDC_CONSTANT_MACROS -D_DARWIN_FEATURE_CLOCK_GETTIME=0 -O3 -mmacosx-version-min=12.5" \
    ${CONFIGURE_OPTS} \
    --arch=${ARCH} \
    --cc=clang

make clean
make -j8 install
