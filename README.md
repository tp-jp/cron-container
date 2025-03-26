# docker-cron-container
このリポジトリは、Alpine Linux ベースの軽量な cron ジョブ実行コンテナイメージを提供します。  
このコンテナは、指定された cron ジョブを実行し、その結果を標準出力へ出力するために使用されます。  
イメージは GitHub Container Registry (GHCR) から直接取得できます。

## 特徴
- 軽量: Alpine Linux をベースにしたコンテナ
- cron サポート: dcron を使用して、設定されたジョブを定期的に実行
- 簡単に設定可能: 任意の cron ジョブ設定ファイルを `/etc/cron.d/` に配置
- ログ出力: 実行した cron ジョブの結果を **標準出力 (stdout)** に出力

## 使用方法
### 1. GitHub Container Registry (GHCR) からイメージを取得  
以下のコマンドで、GHCR からコンテナイメージをプルできます。

```bash
docker pull ghcr.io/tp-jp/cron-container:latest
```

### 2. コンテナを実行  
プルしたイメージを使ってコンテナを実行します。  
`cron.d` フォルダに cron ジョブを配置することで、そのジョブが実行されます。

```bash
docker run -d --name cron-test -v "$(pwd)/cron.d:/etc/cron.d" ghcr.io/tp-jp/cron-container:latest
```

これにより、`cron.d/` フォルダ内に配置した設定ファイルに従って cron ジョブが実行されます。

### 3. Cron ジョブの設定  
cron ジョブは、コンテナ内の `/etc/cron.d/` フォルダに設定ファイルとして配置できます。  
標準出力へ直接出力するには以下のように記述します。

```cron
* * * * * echo "Cron job executed"
```

### 4. ログの確認  
コンテナの標準出力に cron ジョブの実行結果が出力されます。  
以下のコマンドでログを確認できます。

```bash
docker logs cron-test
```

また、特定のログをフィルタリングする場合:

```bash
docker logs cron-test | grep "Cron job executed"
```

**例:**  
以下のように出力されれば cron ジョブが正常に動作しています。

```
crond 4.5 dillon's cron daemon, started with loglevel notice
Cron job executed
Cron job executed
```

### 5. クリーンアップ  
コンテナを停止して削除するには以下のコマンドを実行します。

```bash
docker stop cron-test
docker rm cron-test
```

## Docker Compose の使用例
`docker-compose.yml` を使って、複数のコンテナ設定を簡単に管理することができます。  
以下は `docker-compose.yml` の例です。

```yaml
version: '3.8'

services:
  cron-container:
    image: ghcr.io/tp-jp/cron-container:latest
    container_name: cron-test
    volumes:
      - ./cron.d:/etc/cron.d
    environment:
      - TZ=Asia/Tokyo
    restart: always
```

この設定では、コンテナが永続的に再起動するようにし、`./cron.d` フォルダをコンテナ内の `/etc/cron.d/` にマウントしています。  
また、タイムゾーンを `Asia/Tokyo` に設定し、`restart: always` によってシステム再起動時やコンテナ障害時に自動的に再起動します。

## 注意事項
- cron ジョブの設定は、`/etc/cron.d/` にファイルを配置することで行います。
- 設定ファイルは **ユーザー指定なし** で動作します。ユーザー指定が必要な場合は、`crontab` の使用を検討してください。
- コンテナ内で実行される cron ジョブの結果は、**標準出力 (stdout)** に出力されます。
