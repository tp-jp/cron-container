#!/bin/sh
set -e

# cronログを作成
touch /var/log/cron.log
chmod 666 /var/log/cron.log

# /etc/cron.d 配下のすべての設定ファイルの権限を適正化
chmod 644 /etc/cron.d/cronjobs
chown root:root /etc/cron.d/cronjobs
#chmod 644 /var/spool/cron/crontabs/*
#chown root:root /var/spool/cron/crontabs/*

# cronをバックグラウンドで実行
echo "startup cron..." >> /var/log/cron.log
crond -f

# cronが動いている間はコンテナを保持
# tail -f /var/log/cron.log
