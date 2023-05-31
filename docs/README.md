# 動作確認環境 (GitLab CI/CD でテスト)
* Ubuntu 22.04

# どうやって使うの
`wav/` に wav ファイルを配置してから，以下のコマンドを実行してください。
## コーパスの変更
コーパスの配置場所は `src/corpus/` で、デフォルトのファイル名は `transcript_utf8.txt` です。内容は音声ファイル1つにつき1行で、 `音声ファイル名:台本` の形式です。
## 事前準備
```bash
# apt から必要なソフトウェアをインストール
sudo apt install -y build-essential cmake libasound2 libpulse0 libsndfile1

# pip から必要な python ライブラリをインストール
pip install -r src/requirements.txt
```
## 実行
```bash
bash LABELING.bash
```
これにより `output/` に音素境界付きフルコンテキストラベルと音声が出力されます。

# 謝辞
このプログラムは以下のプログラム等を利用することで動作しています．<br>
各製作者の方々，有難うございます．<br>
* [Julius](https://julius.osdn.jp/index.php?q=newjulius.html): `tools/segmentation-kit/bin/julius/julius-4.6`
* [音素セグメンテーションキット](https://julius.osdn.jp/index.php?q=ouyoukit.html): `tools/segmentation-kit/`
* [JSUT コーパス](https://sites.google.com/site/shinnosuketakamichi/publication/jsut): `corpus/BASIC5000.txt`
