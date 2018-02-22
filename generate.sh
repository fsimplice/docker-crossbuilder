#!/usr/bin/env bash

# Required Bash version (associative arrays)
REQUIRED_MAJOR_BASH_VERSION='4'

declare -A qemus
qemus=(
    [armhf]='qemu-arm-static'
    [aarch64]='qemu-aarch64-static'
)

declare -A patterns
patterns=(
    [__QEMU__]='${qemu}'
    [__ARCH__]='${arch}'
    [__IMAGE_TAG__]='${image_tag}'
)

function build_sed_args {
    result=" "
    for pattern in ${!patterns[*]};do
        variable=${patterns[${pattern}]}
        eval value=$variable
        result+=" -e s/${pattern}/${value}/g"
    done
    echo ${result}
}

function install_template {
    #https://stackoverflow.com/a/965072
    tpl_file=$(basename ${1})
    filename="${tpl_file%.*}"
    SED_ARGS=$(build_sed_args)
    sed -e ${SED_ARGS} ${tpl_file} > ${dockerfileDirectory}/${filename}
    chmod a+x ${dockerfileDirectory}/${filename}
}

function check_bash_version {
    if [[ ${BASH_VERSION%%.*} -lt ${REQUIRED_MAJOR_BASH_VERSION} ]];
    then
        echo "Required Bash version >= ${REQUIRED_MAJOR_BASH_VERSION}"
        exit -1
    fi
}

check_bash_version;

for arch in ${!qemus[*]}; do
    echo "Build tree for arch: ${arch}"
    qemu=${qemus[${arch}]}
    image_tag='latest'
    dockerfileDirectory="${arch}/"
    
    #Install rootfs
    mkdir -p ${dockerfileDirectory}
    cp -r -f cross-build ${dockerfileDirectory}
        
    #Install Dockerfile
    install_template Dockerfile.tpl
        
    #Install build.sh
    install_template build.sh.tpl
done

