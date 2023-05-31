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

import sys
import librosa
import soundfile as sf

def func(input_path, input_dir, output_dir, sr=16000):
    with open(input_path, mode='r') as f:
        lines = f.readlines()
        for i, line in enumerate(lines):
            name = line.split(':')[0]

            # 入出力ファイル名を指定
            input_path  = f"{input_dir}/{name}.wav"
            output_path = f"{output_dir}/{name}.wav"
            
            # sr: 16kHz, rate: 16bit の PCM 形式に音声を変換して出力
            y, sr = librosa.core.load(input_path, sr=sr, mono=True)
            sf.write(output_path, y, sr, subtype='PCM_16')


if __name__ == '__main__':
    func(sys.argv[1], sys.argv[2], sys.argv[3], int(sys.argv[4]))
