#!/usr/bin/env bash

DEMO_DOCKER_IMAGE='ghcr.io/us-joet/appenzell:latest'
DOCKER_VOLUME=""
DOCKER_ENV=""

while getopts i:o: flag
do
    case "${flag}" in
        i) inputDir=${OPTARG};;
        o) outputDir=${OPTARG};;
    esac
done

read_flags() {
    if [[ ! -z "$inputDir" ]]; then
        DOCKER_VOLUME="${DOCKER_VOLUME} -v ${inputDir}:/input"
        DOCKER_ENV="${DOCKER_ENV} -e TEST_INPUT=/input"
    else
        echo "The i flag is required"
        exit 1
    fi

    if [[ ! -z "$outputDir" ]]; then
        DOCKER_VOLUME="${DOCKER_VOLUME} -v ${outputDir}:/output"
        DOCKER_ENV="${DOCKER_ENV} -e TEST_OUTPUT=/output"
    fi
}

download_demo_image() {
    if [ -z "$(docker images -q "${DEMO_DOCKER_IMAGE}" 2> /dev/null)" ]; then
        docker pull --platform linux/amd64 "${DEMO_DOCKER_IMAGE}"
        if [[ "$?" != 0 ]]; then
            echo "Error: Failed to retrieve \"${DEMO_DOCKER_IMAGE}\" from the US-JOET"
        echo 'repository. If this issue persists, please report this as an'
        echo 'issue in the EVerest project:'
        echo '    https://github.com/EVerest/EVerest/issues'
        exit 1
        fi
    fi
}

download_demo_image

read_flags

docker run ${DOCKER_VOLUME} ${DOCKER_ENV} --rm --platform linux/x86_64 ${DEMO_DOCKER_IMAGE}
