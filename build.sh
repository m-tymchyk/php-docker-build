#!/usr/bin/env bash

set -e

docker build \
    --file ./Dockerfile \
    --tag mtymchyk/php-fpm:latest .

docker push mtymchyk/php-fpm:latest