#
# Nextcloud with smbclient
#

# Pull base image.
FROM nextcloud:30.0.8-apache

MAINTAINER Daniel Vogel <Daniel.Vogel@gmx.ch>

# Install.
RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && \
  apt-get -y upgrade && \
  apt-get -y install smbclient libsmbclient-dev libmagickcore-6.q16-6-extra && \
  pecl install smbclient && \
  docker-php-ext-enable smbclient && \
  pecl install inotify && \
  echo "extension=inotify.so" > /usr/local/etc/php/conf.d/pecl-php-ext-inotify.ini && \
  rm -rf /var/lib/apt/lists/* && \
  apt-get clean
