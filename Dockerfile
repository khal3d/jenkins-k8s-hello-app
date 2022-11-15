FROM php:8-alpine

RUN apk update\
    && apk add --no-cache nano git curl bash\
    && apk del

# Install PHP Composer & PHP CS-Fixer
RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer\
    && composer global require friendsofphp/php-cs-fixer
ENV PATH $PATH:/root/.composer/vendor/bin

WORKDIR /var/www/html
