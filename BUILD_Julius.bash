#!/usr/bin/env bash
set -e
WORK_DIR=$(cd $(dirname ${0}); pwd)
DIR_TEMP="${WORK_DIR}/.temp"
DIR_TEMP_LOG="${DIR_TEMP}/log"
DIR_TEMP_LOG_FILE=( \
    "${DIR_TEMP_LOG}/julius_configure.log" \
    "${DIR_TEMP_LOG}/julius_make.log" \
    "${DIR_TEMP_LOG}/exec_segmentation.log" \
)
DIR_SRC="${WORK_DIR}/src"
DIR_SRC_SCRIPTS="${DIR_SRC}/bin"
DIR_SRC_JULIUS_SOURCE="${DIR_SRC}/julius-4.6"
DIR_SRC_JULIUS_BIN="${DIR_SRC}/julius_bin"

rm -rf ${DIR_SRC_JULIUS_BIN};
echo 'step 0: julius のビルド'
cp -RT ${DIR_SRC_JULIUS_SOURCE} ${DIR_SRC_JULIUS_BIN}
(
    cd ${DIR_SRC_JULIUS_BIN}
    ./configure >>  ${DIR_TEMP_LOG_FILE[0]} 2>&1
    make >>         ${DIR_TEMP_LOG_FILE[1]} 2>&1
)
