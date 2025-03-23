#!/bin/bash
set -e
touch /var/log/cron.log
chmod 666 /var/log/cron.log

# cronをバックグラウンドで実行
cron

# cronの設定を再読み込み
crontab /etc/cron.d/cronjobs

# cronが動いている間はコンテナを保持
tail -f /var/log/cron.log
