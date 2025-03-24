#!/bin/sh
set -e

# cronログを作成
#touch /var/log/cron.log
#chmod 666 /var/log/cron.log

# /etc/cron.d 配下のすべての設定ファイルの権限を適正化
chmod 644 /etc/cron.d/*
chown root:root /etc/cron.d/*

# cronをバックグラウンドで実行
crond -l 0 -f
