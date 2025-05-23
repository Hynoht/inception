#!/bin/bash

set -e

REDIS_PASSWORD=$(cat /run/secrets/redis_password)

sed -i 's/^# *requirepass .*/requirepass '"$REDIS_PASSWORD"'/' /etc/redis/redis.conf

exec redis-server /etc/redis/redis.conf