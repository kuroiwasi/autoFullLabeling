#!/bin/bash
set -e # エラー時に停止させる
script_path=$(cd $(dirname ${0}); pwd)

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

### ここは実行前に設定する変数 ###

# コーパスのパス
corpath="${script_path}/src/corpus/BASIC5000.txt"
# コーパスの文章数
list_row=5000

############################################################
### ここから下は触ると大変なことになるかもだから触るなら心して触れ ###
############################################################

wav_dir="${script_path}/wav"                # 音声フォルダ

temp_dir="${script_path}/.temp"             # temp フォルダ
labels_dir="${temp_dir}/labels"             # ラベルフォルダ
logfiles_dir="${temp_dir}/log"              # ログフォルダ

src_dir="${script_path}/src"
segment_kit="${src_dir}/segmentation-kit"   # 音素セグメンテーションキット
segment_wav="${segment_kit}/wav"            # レート調整された音声ファイル
scripts_dir="${src_dir}/bin"                # スクリプトの保存フォルダ

output_dir="${script_path}/output"          # 最終結果の保存場所
output_labels="${output_dir}/lab"           # 最終ラベル
output_wavs="${output_dir}/wav"             # 最終音声

# ディレクトリをリフレッシュ
## ディレクトリを一度削除
remove_dirs=(${temp_dir} ${segment_wav} ${output_dir})
for dir in ${remove_dirs[@]}
do
    if [ -d ${dir} ]; then rm -rf ${dir}; fi
done
## 必要なディレクトリを作成
create_dirs=(${temp_dir} ${labels_dir} ${logfiles_dir} ${segment_wav} \
${output_dir} ${output_labels} ${output_wavs})  
for dir in ${create_dirs[@]}
do
    mkdir -p ${dir}
done
## ラベルの一時保存ディレクトリを作成
step_dirs=("${labels_dir}/00" "${labels_dir}/01_時間情報削除済みラベル" \
"${labels_dir}/02_ローマ字台本" "${labels_dir}/03_新時間情報モノフォンラベル" \
"${labels_dir}/04_時間情報のみ" "${labels_dir}/05_時間情報付きフルコンテキストラベル")
for dir in ${step_dirs[@]}
do
    mkdir -p ${dir}
done

# ログの保存先パスを設定
log_file=("${logfiles_dir}/00_configure.log" "${logfiles_dir}/00_make.log" \
"${logfiles_dir}/04_segment.log")

# 削除されてしまう gitkeep の復元
touch ${wav_dir}/.gitkeep

# コーパス -> 時間情報なしフルコンテキストラベル
echo "step 1: 台本をフルコンテキストラベルに変換"
python3 ${scripts_dir}/Kanji2Full.py ${list_row} ${corpath} ${step_dirs[1]}

# コーパス -> ローマ字ファイル
echo "step 2: julius 用のローマ字台本ファイル作成"
python3 ${scripts_dir}/Kanji2Roma.py ${list_row} ${corpath} ${step_dirs[2]}

# 録音音声 & ローマ字ファイル -> 時間情報ありモノフォンラベル
echo "step 3: julius を利用した強制音素アライメント"
## データのコピー
cp -RT ${step_dirs[2]} ${segment_wav} # ローマ字台本をコピー
python3 ${scripts_dir}/Change_Rate.py ${list_row} ${wav_dir} ${segment_wav} # 音声ファイルをコピー
## 強制音素アライメントの生成をサブシェルで実行
(cd ${segment_kit}; perl segment_julius.pl) >> ${log_file[2]} 2>&1
## 生成されたデータをコピー
cp ${segment_wav}/*.lab ${step_dirs[3]}

# 時間情報ありモノフォンラベル -> 時間情報のみ
echo "step 4: 音素アライメントから時間情報の抽出"
python3 ${scripts_dir}/Remove_Time.py ${list_row} ${step_dirs[3]} ${step_dirs[4]}

# 時間情報のみ & 時間情報なしフルコンテキストラベル -> 時間情報ありフルコンテキストラベル
echo "step 5: 時間情報ありフルコンテキストラベルの作成"
python3 ${scripts_dir}/Connect_Files.py ${list_row} ${step_dirs[1]} ${step_dirs[4]} ${step_dirs[5]}

# output にファイルを出力
cp -RT ${step_dirs[5]} ${output_labels}
cp -RT ${wav_dir} ${output_wavs}
