#!/bin/bash
:<<LICENCE
Copyright 2022 Fumiyoshi MATANO

This file is part of DNNTTS-With-YourVoice.

DNNTTS-With-YourVoice is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software Foundation,
either version 3 of the License, or (at your option) any later version.

DNNTTS-With-YourVoice is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with DNNTTS-With-YourVoice.
If not, see <https://www.gnu.org/licenses/>. 
LICENCE

set -e
WORK_DIR=$(cd $(dirname ${0}); pwd)

### ここは実行前に設定する変数 ###

CORPATH="${WORK_DIR}/src/corpus/BASIC5000.txt"
LIST_ROW=5000 # コーパスの文章数

### ここまで ###

DIR_WAV="${WORK_DIR}/wav"     
DIR_TEMP="${WORK_DIR}/.temp"
DIR_TEMP_LABELS="${DIR_TEMP}/labels"
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
DIR_SRC_SEGMRNT_KIT="${DIR_SRC}/segmentation-kit"
DIR_SRC_SEGMENT_WAV="${DIR_SRC_SEGMRNT_KIT}/wav"

DIR_OUTPUT="${WORK_DIR}/output"
DIR_OUTPUT_LABELS="${DIR_OUTPUT}/lab"
DIR_OUTPUT_WAV="${DIR_OUTPUT}/wav"


remove_dirs=( ${DIR_TEMP} ${DIR_SRC_JULIUS_BIN} ${DIR_SRC_SEGMENT_WAV} ${DIR_OUTPUT})
for dir in ${remove_dirs[@]}; do rm -rf ${dir}; done

create_dirs=( \
    ${DIR_TEMP} ${DIR_TEMP_LABELS} ${DIR_TEMP_LOG} \
    ${DIR_SRC_SEGMENT_WAV} \
    ${DIR_OUTPUT} ${DIR_OUTPUT_LABELS} ${DIR_OUTPUT_WAV} \
)  
for dir in ${create_dirs[@]}; do mkdir -p ${dir}; done

step_dirs=( \
    "${LABEL_DIR}/00" "${LABEL_DIR}/01_時間情報削除済みラベル" \
    "${LABEL_DIR}/02_ローマ字台本" "${LABEL_DIR}/03_新時間情報モノフォンラベル" \
    "${LABEL_DIR}/04_時間情報のみ" "${LABEL_DIR}/05_時間情報付きフルコンテキストラベル" \
)
for dir in ${step_dirs[@]}; do mkdir -p ${dir}; done


echo 'step 0: julius のビルド'
cp -RT ${DIR_SRC_JULIUS_SOURCE} ${DIR_SRC_JULIUS_BIN}
(
    cd ${DIR_SRC_JULIUS_BIN}
    ./configure >>  ${DIR_TEMP_LOG_FILE[0]} 2>&1
    make >>         ${DIR_TEMP_LOG_FILE[1]} 2>&1
)


echo "step 1: コーパス -> 時間情報なしフルコンテキストラベル"
python3 ${DIR_SRC_SCRIPTS}/Kanji2Full.py ${LIST_ROW} \
    ${CORPATH} ${step_dirs[1]}


echo "step 2: コーパス -> 時間情報なしモノフォンラベル"
python3 ${DIR_SRC_SCRIPTS}/Kanji2Roma.py ${LIST_ROW} \
    ${CORPATH} ${step_dirs[2]}


echo "step 3: 録音音声 & 時間情報なしモノフォンラベル -> 時間情報ありモノフォンラベル"
# データのコピー
cp -RT ${step_dirs[2]} ${DIR_SRC_SEGMENT_WAV}
python3 ${DIR_SRC_SCRIPTS}/Change_Rate.py ${LIST_ROW} ${DIR_WAV} ${DIR_SRC_SEGMENT_WAV}
# 時間情報ありモノフォンラベルの生成
(cd ${DIR_SRC_SEGMRNT_KIT}; perl segment_julius.pl) >> ${log_file[2]} 2>&1
cp ${DIR_SRC_SEGMENT_WAV}/*.lab ${step_dirs[3]} # 生成されたデータをコピー


echo "step 4: 時間情報ありモノフォンラベル -> 時間情報"
python3 ${DIR_SRC_SCRIPTS}/Remove_Time.py ${LIST_ROW} \
    ${step_dirs[3]} ${step_dirs[4]}


echo "step 5: 時間情報 & 時間情報なしフルコンテキストラベル -> 時間情報ありフルコンテキストラベル"
python3 ${DIR_SRC_SCRIPTS}/Connect_Files.py ${LIST_ROW} \
    ${step_dirs[1]} ${step_dirs[4]} ${step_dirs[5]}


echo "step 6: output ディレクトリにデータを出力"
cp -RT ${step_dirs[5]} ${DIR_OUTPUT_LABELS}
cp -RT ${DIR_WAV} ${DIR_OUTPUT_WAV}
