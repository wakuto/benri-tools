# 便利tools
個人用に作成した便利スクリプト集です。

## 自動変換たん
.tsファイルを.mp4に変換します。

### 必要なもの
- nvenc対応GPU
- ffmpeg
- windows10

### 使い方
ショートカットを作成し、プロパティーのリンク先を
```
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy RemoteSigned -File [自動変換たんのパス]
```
のようにするとショートカットから起動することができます。
ショートカットにファイルをD&Dすることもできます。
| 操作            | 変換されるファイル                          | 
| -------------- | ------------------------------------------ | 
| そのまま実行    | スクリプト内で指定したフォルダ直下のtsファイル | 
| tsファイルをD&D | D&Dしたtsファイル                           | 
| フォルダをD&D   | D&Dしたフォルダ直下のtsファイル              | 

mp4ファイルは入力されたtsファイルと同じ場所に生成されます。
tsファイルと同じ名前のmp4ファイルがある場合、その動画は変換されません。

終了時はトースト通知でお知らせします。
