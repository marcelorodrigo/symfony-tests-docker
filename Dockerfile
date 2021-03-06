
FROM php:7.1-alpine
MAINTAINER Marcelo Rodrigo <mrodrigow@gmail.com>

RUN apk add --no-cache \
    # for intl extension
    icu-dev \
    # for mcrypt extension
    libmcrypt-dev \
    # for gd extension
    freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev

RUN docker-php-ext-install intl

RUN docker-php-ext-configure gd \
    --with-gd \
    --with-freetype-dir=/usr/include/ \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ && \
    NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
    docker-php-ext-install -j${NPROC} gd

RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install mcrypt

RUN apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev
