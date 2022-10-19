# DNNTTS-with-YourVoice ver. 0.1.0
ダウンロードは [>> こちら <<](https://gitlab.com/f-matano44/dnntts-with-yourvoice/-/releases)
## これはなに
これは [ttslearn](https://github.com/r9y9/ttslearn) を用いた DNNTTS 学習のために必要な時間情報付きフルコンテキストラベルを、Julius と pyopenjtalk を使って、台本 (JSUT コーパス - BASIC5000) と音声から生成するプログラムです。<br>
## 作者の環境
### Linux
* Linux mint 20.3 edge
### macOS
* Docker Desktop version 20.10.17
* Docker Compose version v2.10.2
## どうやって使うの
### 事前準備
#### Python ライブラリ
`requirements.txt` にまとめておいたので、pip を使う場合はそこからインストールしてください。
```
$ pip install -r ./requirements.txt
```
#### 録音データの配置
`/wav/` に `BASIC5000_xxxx.wav` の形式で配置してください。 xxxx には対応する台本の番号が入ります。<br>
ex. 123 番の台本の場合: `BASIC5000_0123.wav`
### 実行
#### Linux
```
bash scripts/LABELING.bash
```
#### macOS
```bash
# コンテナのビルド・起動
docker-compose up -d --build
docker-compose exec dnntts bash

# ラベリングの実行
bash scripts/LABELING.bash

# コンテナの停止・削除
exit # Docker 環境から退出
docker-compose down
```

DNNTTS with YourVoice のルートディレクトリに移動して以上のコマンドを実行してください。そうすると `/labels/05_時間情報付きフルコンテキストラベル` に音素境界付きフルコンテキストラベルが出力されます。<br>
# 謝辞
このプログラムは以下のプログラムを利用することで動作しています．<br>
各製作者の方々，有難うございます．<br>
* [Julius](https://julius.osdn.jp/index.php?q=newjulius.html): `/tools/segmentation-kit/bin/julius-4.6`
* [音素セグメンテーションキット](https://julius.osdn.jp/index.php?q=ouyoukit.html): `/tools/segmentation-kit/`