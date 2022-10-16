# DNNTTS-with-YourVoice ver. 0.1.0
ダウンロードは [>> こちら <<](https://gitlab.com/f-matano44/dnntts-with-yourvoice/-/releases)
## これはなに
これは [ttslearn](https://github.com/r9y9/ttslearn) を用いた DNNTTS 学習のために必要な時間情報付きフルコンテキストラベルを、便利ツール (Julius と pyopenjtalk) を使って、台本 (JSUT コーパス - BASIC5000) とその台本を読み上げた音声から生成するプログラムです。<br>
動作確認は JSUT コーパス付属の音声を使って確かめたところ、ラベルの作成とそれを用いての合成音声生成までは確認しました。自分の声を用いての動作確認はまだしてないです、そのうちします。
## 作者の環境
### Linux
Linux mint 20.3 edge
### macOS
* Docker Desktop version 20.10.17
* Docker Compose version v2.10.2
## どうやって使うの
### 事前準備
#### Python ライブラリ
`requirements.txt` にまとめておいたので、そこからインストールしてください。
```
$ pip install -r ./requirements.txt
```
#### 録音データの配置
`/wav/` に `BASIC5000_xxxx.wav` の形式で配置してください。 xxxx には対応する台本の番号が入ります。<br>
ex. 123 番の台本の場合: `BASIC5000_0123.wav`
### 実行
#### Linux
```
$ bash LABELING.bash
```
#### macOS
```bash
# コンテナのビルド・起動
docker-compose up -d --build
docker-compose exec dnntts bash

# ラベリングの実行
bash LABELING.bash

# コンテナの停止・削除
exit
docker-compose down
```

DNNTTS with YourVoice のルートディレクトリに移動して以上のコマンドを実行してください。そうすると `/labels/05_時間情報付きフルコンテキストラベル` に音素境界付きフルコンテキストラベルが出力されます。<br>
# 謝辞
このプログラムは以下のプログラムを利用することで動作しています．<br>
各製作者の方々，有難うございます．<br>
* [Julius](https://julius.osdn.jp/index.php?q=newjulius.html): `/tools/segmentation-kit/bin/julius-4.6`
  * BSD 3-Clause License: https://github.com/julius-speech/julius/blob/master/LICENSE
  * Copyright (c) 1991-2020 Kawahara Lab., Kyoto University
  * Copyright (c) 1997-2000 Information-technology Promotion Agency, Japan
  * Copyright (c) 2000-2005 Shikano Lab., Nara Institute of Science and Technology
  * Copyright (c) 2005-2020 Julius project team, Nagoya Institute of Technology
* [音素セグメンテーションキット](https://julius.osdn.jp/index.php?q=ouyoukit.html): `/tools/segmentation-kit/`
  * The MIT License (MIT): https://github.com/julius-speech/segmentation-kit/blob/master/License.md
  * Copyright (c) 2005-2015 Julius project team, Lee Lab., Nagoya Institute of Technology
  * Copyright (c) 2008 Ryuichi Nisimura 
