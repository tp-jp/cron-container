#!/bin/bash
set -e
touch /var/log/cron.log
chmod 666 /var/log/cron.log

#echo '* * * * * root echo "Cron job executed" >> /var/log/cron.log 2>&1' > cronjobs
#echo '' >> cronjobs  # 最後に改行がないと cron が動かないことがある
#chmod 644 cronjobs
#chown root:root cronjobs
#mv cronjobs /etc/cron.d/cronjobs
ls -lah /etc/cron.d
cat /etc/cron.d/cronjobs

# cronをバックグラウンドで実行
cron

# cronが動いている間はコンテナを保持
tail -f /var/log/cron.log
