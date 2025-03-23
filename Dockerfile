FROM alpine:latest

# 必要なパッケージをインストール
RUN apk update && apk add --no-cache \
    dcron \
    docker-cli \
    && rm -rf /var/cache/apk/*

# コンテナ内のcronサービスを開始するためのスクリプトをコピー
COPY ./endpoint.sh /usr/local/bin/endpoint.sh
RUN chmod +x /usr/local/bin/endpoint.sh

COPY ./tests/testjob.sh /usr/local/bin/testjob.sh
RUN chmod +x /usr/local/bin/testjob.sh

# cronをバックグラウンドで実行
CMD ["sh", "/usr/local/bin/endpoint.sh"]
