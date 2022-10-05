# DNNTTS-with-YourVoice ver. 0.0.3d
ダウンロードは [>> こちら <<](https://gitlab.com/f-matano44/dnntts-with-yourvoice/-/releases)
## これはなに
これは [ttslearn](https://github.com/r9y9/ttslearn) を用いた DNNTTS 学習のために必要な時間情報付きフルコンテキストラベルを、便利ツール (Julius と pyopenjtalk) を使って、台本 (JSUT コーパス - BASIC5000) とその台本を読み上げた音声から生成するプログラムです。<br>
動作確認は JSUT コーパス付属の音声を使って確かめたところ、ラベルの作成とそれを用いての合成音声生成までは確認しました。自分の声を用いての動作確認はまだしてないです、そのうちします。
## 作者の環境
* Docker Desktop version 20.10.17
* Docker Compose version v2.10.2
## どうやって使うの
### 事前準備
#### 外部ツール
以下のディレクトリ構造になるようにファイルをセットし、一部設定を変更して `LABELING.bash` を実行すれば O.K. です。必要なファイルはリンクをおいておくので各自解凍してセットしてください。<br>
- [JSUT コーパス](https://sites.google.com/site/shinnosuketakamichi/publication/jsut): `/corpus/jsut_ver1.1/`
- [Julius](https://julius.osdn.jp/index.php?q=newjulius.html): `/tools/julius/`
- [音素セグメンテーションキット](https://julius.osdn.jp/index.php?q=ouyoukit.html): `/tools/segmentation-kit/`

変更する必要がある設定: `segmentation-kit/segment_julius.pl` の `## julius executable` にある else 文のパスを `$juliusbin="../julius_bin/julius/julius";` に変更

#### 録音データの配置
`/wav/` に `BASIC5000_xxxx.wav` の形式で配置してください。 xxxx には対応する台本の番号が入ります。<br>
ex. 123 番の台本の場合: `BASIC5000_0123.wav`
### 実行

```bash
# コンテナのビルド・起動
docker-compose up -d --build
docker-compose exec dnntts bash

# ラベリングの実行
bash LABELING.bash

# コンテナの停止・削除
docker-compose down
```

DNNTTS with YourVoice のルートディレクトリに移動して以上のコマンドを実行してください。そうすると `/labels/05_時間情報付きフルコンテキストラベル` に音素境界付きフルコンテキストラベルが出力されます。<br>
