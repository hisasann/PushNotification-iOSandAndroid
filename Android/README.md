# GCMを使ったPush通知サンプル

## サーバー側のコード - Pushを送る側

今回はJavaで書いてみました。Javaだと楽ちん！

Javaのバージョンは1.6を使用。

コードとしては、

### Java

* GCMServer.java

### ライブラリ

必要なライブラリは、

* gcm-server.jar
* json_simple-1.1.jar

になります。

### 証明書ファイル

特になし。

## アプリ側のコード - Pushを受け取る側

MainActivityはただ、GCMRegistrarをキックしているだけ。

ServerUtilitiesはtokenを登録するようのロジック用クラス。

GCMIntentServiceがGCMを使う本体。

AndroidManifest.xmlにはGCMまわりの記述が書かれている。

1. MainActivity.java
2. ServerUtilities.java
3. GCMIntentService.java
4. AndroidManifest.xml

## メモ
* Push通知は、何度もテストしていると通知が少し遅れてくる場合がある。

