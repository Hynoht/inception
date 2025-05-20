#!/bin/bash

set -e

REDIS_PASSWORD=$(cat /run/secrets/redis_password)

echo "requirepass $REDIS_PASSWORD" >> /usr/local/etc/redis/redis.conf

exec redis-server /usr/local/etc/redis/redis.conf