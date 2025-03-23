FROM ubuntu:20.04

# 必要なパッケージをインストール
RUN apt-get update && apt-get install -y \
  cron \
  docker.io \
  && rm -rf /var/lib/apt/lists/*

# コンテナ内のcronサービスを開始するためのスクリプトをコピー
COPY ./endpoint.sh /usr/local/bin/endpoint.sh
RUN chmod +x /usr/local/bin/endpoint.sh

# cronジョブを実行するためにコンテナを開始
CMD ["/usr/local/bin/endpoint.sh"]
