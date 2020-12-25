FROM php:7.4-apache

WORKDIR /
RUN curl -L https://github.com/CatoTH/antragsgruen/releases/download/v4.6.3/antragsgruen-4.6.3.tar.bz2 -o ag.tar.bz2 && \
    tar -xjf ag.tar.bz2 && \
    rm -fr /var/www/html && \
    mv antragsgruen-4.6.3 /var/www/html && \
    chown -R www-data:www-data /var/www/html/web/assets && \
    chown -R www-data:www-data /var/www/html/runtime && \
    rm /var/www/html/config/INSTALLING && \
    rm ag.tar.bz2

RUN docker-php-ext-install -j$(nproc) mysqli pdo_mysql 
# Enable common Apache modules
RUN a2enmod headers expires rewrite

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

COPY custom/ /var/www/html/
COPY httpd/vhost.conf /etc/apache2/sites-available/000-default.conf
