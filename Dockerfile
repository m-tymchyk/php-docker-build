FROM php:7.1.7-fpm-alpine

ENV COMPOSER_ALLOW_SUPERUSER=1
ENV PHP_GEOIP_VERSION=1.1.1
ENV PYTHON_VERSION=2.7.14-r0
ENV PY_PIP_VERSION=8.1.2-r0
ENV SUPERVISOR_VERSION=3.3.1

RUN apk add \
        --no-cache \
            curl \
            nano \
            geoip \
            gettext \
            icu \
            git \
            postgresql \
            python=$PYTHON_VERSION \
            py-pip=$PY_PIP_VERSION && \
    apk add \
        --no-cache \
        --virtual \
        .build-deps \
            geoip-dev \
            g++ \
            make \
            libc-dev \
            dpkg \
            dpkg-dev \
            gettext-dev \
            icu-dev \
            autoconf \
            postgresql-dev && \
    pecl install http://pecl.php.net/get/geoip-$PHP_GEOIP_VERSION.tgz && \
    docker-php-ext-enable geoip && \
    docker-php-ext-install pdo_mysql pdo_pgsql intl pcntl gettext mysqli zip bcmath sockets iconv && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    pip install supervisor==$SUPERVISOR_VERSION && \
    apk del .build-deps && \
    rm -rf /var/www/html

RUN mkdir -p /var/log/supervisord