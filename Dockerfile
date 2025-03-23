FROM alpine:latest

# 必要なパッケージをインストール
RUN apk add --no-cache \
  dcron \
  docker-cli

# コンテナ内のcronサービスを開始するためのスクリプトをコピー
COPY ./endpoint.sh /usr/local/bin/endpoint.sh
RUN chmod +x /usr/local/bin/endpoint.sh

# cronジョブを実行するためにコンテナを開始
CMD ["/usr/local/bin/endpoint.sh"]
