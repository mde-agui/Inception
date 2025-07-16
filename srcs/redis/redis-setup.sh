#!/bin/bash

sed -i "|\${REDIS_PASS}|${REDIS_PASS}|g" /etc/redis.conf

exec redis-server /etc/redis.conf
