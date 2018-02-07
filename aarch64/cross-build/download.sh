#!/usr/bin/env bash

_GREEN_="\033[0;32m"
_RED_="\033[0;31m"
_NO_COLOR_="\033[0m"

QEMU_ARM_VERSION='2.9.0.resin1-arm'
QEMU_AARCH64_VERSION='2.9.0.resin1-aarch64'
RESIN_XBUILD_VERSION='1.0.0'

QEMU_ARM_FILE="https://github.com/resin-io/qemu/releases/download/v2.9.0+resin1/qemu-${QEMU_ARM_VERSION}.tar.gz"
QEMU_ARM_SHA256='b39d6a878c013abb24f4cccc7c3a79829546ae365069d5712142a4ad21bcb91b'

QEMU_AARCH64_FILE="https://github.com/resin-io/qemu/releases/download/v2.9.0+resin1/qemu-${QEMU_AARCH64_VERSION}.tar.gz"
QEMU_AARCH64_SHA256='ebd9c4f4ab005f183b8d84b121b5b791c39c5a92013e590e00705e958c5b5c48'

RESIN_XBUILD_FILE="http://resin-packages.s3.amazonaws.com/resin-xbuild/v${RESIN_XBUILD_VERSION}/resin-xbuild${RESIN_XBUILD_VERSION}.tar.gz"
RESIN_XBUILD_SHA256='1eb099bc3176ed078aa93bd5852dbab9219738d16434c87fc9af499368423437'

function https_download {
    URL=$1
    SHA256=$2
    TAR_OPTS=$3
    echo "Untar ${URL##*/}"
    curl -SLO ${URL} \
        && echo "${SHA256} ${URL##*/}" | sha256sum -c - \
        && tar -vxz ${TAR_OPTS} -f ${URL##*/}
    if [[ $? != 0 ]];
    then
        printf "[${_RED_}FAILED${_NO_COLOR_}] Downloaded ${URL}\n"
        exit 1
    else 
        printf "[${_GREEN_}SUCCESS${_NO_COLOR_}] Downloaded ${URL}\n"
    fi

}

# Download QEMU
https_download  "${QEMU_ARM_FILE}" "${QEMU_ARM_SHA256}" "--strip-components=1"
https_download  "${QEMU_AARCH64_FILE}" "${QEMU_AARCH64_SHA256}" "--strip-components=1"
https_download  "${RESIN_XBUILD_FILE}" "${RESIN_XBUILD_SHA256}"

rm *.tar.gz