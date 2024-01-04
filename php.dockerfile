FROM php:8-fpm-alpine

ENV PHP_GROUP=developer
ENV PHP_USER=developer

RUN adduser -g ${PHP_GROUP} -s /bin/sh -D ${PHP_USER}

RUN sed -i "s/user = www-data/user = ${PHP_USER}/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/group = www-data/group = ${PHP_GROUP}/g" /usr/local/etc/php-fpm.d/www.conf

RUN mkdir -p /var/www/html/public

CMD ["php-fpm", "-y", "/usr/local/etc/php-fpm.conf", "-R"]