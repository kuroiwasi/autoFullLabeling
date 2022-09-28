#!/usr/bin/env python3

"""
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
"""

import csv
import numpy as np
import num2index as n2i

def main():
    for i in range(5000):
        # 入出力ファイル名を設定
        index = n2i.num2index(i + 1)
        label_path = './labels/02_時間情報削除済みラベル/BASIC5000_' + index + '.lab'
        time_path = './labels/05_時間情報のみ/BASIC5000_' + index + '.lab'
        output_path = './labels/06_時間情報付きフルコンテキストラベル/BASIC5000_' + index + '.lab'

        with open(label_path, 'rt') as labeldata:
            with open(time_path, 'rt') as timedata:
                # 各種データの読み込み
                timearray = np.array(list(csv.reader(timedata, delimiter = ' ')))   # time データを 2 次元配列に格納
                labelarray = np.array(list(csv.reader(labeldata, delimiter = ' '))) # label データを 2 次元配列に格納
                array = np.concatenate([timearray, labelarray], axis=1)             # time と label を横に結合
                # ラベルデータの書き出し
                with open(output_path, 'wt') as f:
                    writer = csv.writer(f, delimiter=' ', lineterminator='\n')
                    writer.writerows(array)

if __name__ == "__main__":
    main()