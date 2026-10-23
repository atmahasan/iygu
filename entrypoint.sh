#!/bin/sh
set -e
# آی‌پی fly-global-services را پیدا و در کانفیگ جایگذاری کن
BIND_IP=$(getent hosts fly-global-services | awk '{print $1}')
sed -i "s/__FLY_BIND_IP__/${BIND_IP}/" /app/server_config.toml
# کلید روی volume بماند
ln -sf /data/encrypt_key.txt /app/encrypt_key.txt
exec /app/server
