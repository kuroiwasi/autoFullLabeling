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
import num2index as n2i

def main():
    for i in range(5000):
        # 入出力ファイル名を設定
        index = n2i.num2index(i + 1)
        input_path = './labels/03_新時間情報モノフォンラベル/BASIC5000_' + index + '.lab'
        output_path = './labels/04_時間情報のみ/BASIC5000_' + index + '.lab'

        with open(input_path, 'rt') as f:
            # ラベルデータの読み込み
            array = list(csv.reader(f, delimiter = ' ')) # label データを 2 次元配列に格納
            for row in array: del row[2] # ラベル情報 (3 列目) の削除
            # ラベルデータの書き出し
            with open(output_path, 'wt') as g:
                writer = csv.writer(g, delimiter=' ', lineterminator='\n')
                writer.writerows(array)

if __name__ == "__main__":
    main()