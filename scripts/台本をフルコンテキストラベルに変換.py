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

import num2index as n2i
import pyopenjtalk as poj

def main():
    # 入力ファイルの設定
    input_path = './corpus/jsut_ver1.1/basic5000/transcript_utf8.txt'
    with open(input_path, 'rt') as f:
        # 台本データの読み込み
        array = f.read().split('\n') # 台本データを 1 次元配列に格納
        
        for i in range(5000):
            # 台本番号の削除
            array[i] = array[i][15:]
            # 出力ファイルの設定
            index = n2i.num2index(i + 1)
            output_path = './labels/02_時間情報削除済みラベル/BASIC5000_' + index + '.lab'
            
            # フルコンテキストラベルの生成
            full_labels = poj.extract_fullcontext(array[i])
            # ラベルデータの書き出し
            output_str = '\n'.join(full_labels) # 1 次元配列を改行文字列に変換
            with open(output_path, 'wt') as g: g.write(output_str) # 書き出し

if __name__ == "__main__":
    main()