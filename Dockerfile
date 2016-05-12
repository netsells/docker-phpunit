FROM netsells/composer

MAINTAINER "Sam Jordan" <sam@netsells.co.uk>

# Run some Debian packages installation.
ENV PACKAGES="php-pear curl"
RUN apt-get update && \
    apt-get install -yq --no-install-recommends $PACKAGES && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Goto temporary directory.
WORKDIR /tmp

# Run composer and phpunit installation.
RUN composer selfupdate && \
    composer require "phpunit/phpunit:~5.0.3" --prefer-source --no-interaction && \
    ln -s /tmp/vendor/bin/phpunit /usr/local/bin/phpunit

COPY config/php.ini /usr/local/etc/php/

WORKDIR /data

ENTRYPOINT ["/usr/local/bin/phpunit"]
CMD ["--version"]
