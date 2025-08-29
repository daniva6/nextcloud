#
# Nextcloud with smbclient
#

# Pull base image.
FROM nextcloud:31.0.8-apache

MAINTAINER Daniel Vogel <Daniel.Vogel@gmx.ch>

# Install.
RUN set -eux; \
    # Install required packages
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        smbclient \
        libmagickcore-7.q16-*-extra \
        pkg-config \
        libtool \
        autoconf \
        make \
        gcc \
        libc-dev \
        libsmbclient-dev \
        && \
    # Install PHP extensions from PECL
    pecl install smbclient && \
    docker-php-ext-enable smbclient && \
    pecl install inotify && \
    echo "extension=inotify.so" > /usr/local/etc/php/conf.d/inotify.ini && \
    # Cleanup
    rm -rf /var/lib/apt/lists/*
