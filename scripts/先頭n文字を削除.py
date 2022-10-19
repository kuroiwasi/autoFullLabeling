#!/usr/bin/env python3
# 使い方
# python 先頭n文字を削除.py (削除文字数) (input_path) (output_path)

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

import sys

def main(rmnum, input_path, output_path):
    with open(input_path, 'rt') as input_file:
        # 漢字台本データの読み込み
        array = input_file.read().split('\n') # 台本データを 1 次元配列に格納
        # 先頭 15 文字を削除
        for i in range(len(array)): array[i] = array[i][rmnum:]

        # ラベルデータの書き出し
        output_str = '\n'.join(array) # 1 次元配列を改行文字列に変換
        with open(output_path, 'wt') as output_file:
            output_file.write(output_str) # 書き出し

if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2], sys.argv[3])