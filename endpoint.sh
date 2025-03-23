#!/bin/bash
set -e
touch /var/log/cron.log
chmod 666 /var/log/cron.log

# cronをバックグラウンドで実行
echo "startup cron..." >> /var/log/cron.log
cron

# cronが動いている間はコンテナを保持
tail -f /var/log/cron.log
