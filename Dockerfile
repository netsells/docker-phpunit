FROM phpunit/phpunit

MAINTAINER "Sam Jordan" <sam@netsells.co.uk>

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libmysqlclient-dev \
    && docker-php-ext-install iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install mysqli pdo pdo_mysql

COPY config/php.ini /usr/local/etc/php/

WORKDIR /data

ENTRYPOINT ["/usr/local/bin/phpunit"]
CMD ["--version"]