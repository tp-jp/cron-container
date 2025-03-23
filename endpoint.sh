#!/bin/bash

# cronをバックグラウンドで実行
cron

# cronが動いている間はコンテナを保持
tail -f /var/log/cron.log
