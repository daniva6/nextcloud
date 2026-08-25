#
# Nextcloud v33 with smbclient and inotify
#
FROM nextcloud:33.0.8-apache

LABEL maintainer="Daniel Vogel <Daniel.Vogel@gmx.ch>"

ENV DEBIAN_FRONTEND=noninteractive

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        smbclient \
        libsmbclient-dev \
        libmagickcore-7.q16-*-extra \
        pkg-config \
        build-essential \
        libtool \
        autoconf \
        && \
    pecl install smbclient inotify && \
    docker-php-ext-enable smbclient inotify && \
    apt-get purge -y --auto-remove \
        libsmbclient-dev \
        pkg-config \
        build-essential \
        libtool \
        autoconf \
        && \
    rm -rf /var/lib/apt/lists/*