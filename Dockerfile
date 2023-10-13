FROM php:7.4-apache-bullseye

# Installer les dépendances 
RUN apt-get update && apt-get install -y \
    git=1:2.30.2-1+deb11u2 \
    wget=1.21-1+deb11u1 \
    ffmpeg=7:4.3.6-0+deb11u1 \
    lsb-release

# Fonctions PHP
RUN docker-php-ext-install bcmath sockets

# Installation de composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && rm composer-setup.php \
    && php -r "unlink('composer-setup.php');"

COPY . /var/www/html/

RUN composer install 

