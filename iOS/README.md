# Apple Push Notification Service（APNS）を使ったPush通知サンプル

## サーバー側のコード - Pushを送る側

今回はJavaで書いてみました。Javaだと楽ちん！
Javaのバージョンは1.6を使用。

コードとしては、

### Java

* APNSServer.java

### ライブラリ

必要なライブラリは、

* bcprov-jdk15-146.jar
* JavaPNS_2.2.jar
* log4j-1.2.15.jar

になります。

### 証明書ファイル（.p12ファイル）

あとは、.p12ファイルをiOS Provisioning PortalのApp IDsからダウンロードしておく。

* development.p12（デバッグ用）
* distribution.p12（リリース用）

## アプリ側のコード - Pushを受け取る側

アプリ側でPushが来るパターンは以下の3つ

1. フォアグラウンドでプッシュ通知を受け取ったとき
2. アプリのプロセスがバックグラウンドで生きているときにプッシュ通知を受け取り、ユーザーがアクションボタンをタップしたとき
3. アプリのプロセスがバックグラウンドで生きていないときにプッシュ通知を受け取り、ユーザーがアクションボタンをタップしたとき

ただ、2の項目は、アプリ内にバッジのようなものを表示する場合は、
ここではやらずapplicationDidBecomeActiveでやるようにしている。

[via](http://d.hatena.ne.jp/shu223/20110828/1314516533)

### Objective-C

* AppDelegate.m

## メモ
* Push通知は、何度もテストしていると通知が少し遅れてくる場合がある。
* iOSアプリをdebugモードでビルドして、Push通知時にDistribution用の証明書でPush通知をすると、通知が来ないが、さらに連続してこれを行うと、2・3日Push通知が来ない状態になる場合がある。

