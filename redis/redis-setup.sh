#!/bin/bash

sed -i "s|\${REDIS_PASS}|${REDIS_PASS}|g" /etc/redis.conf

exec redis-server /etc/redis.conf
