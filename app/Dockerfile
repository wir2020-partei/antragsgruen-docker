FROM webdevops/php-apache:7.4

RUN wget https://github.com/CatoTH/antragsgruen/releases/download/v4.6.3/antragsgruen-4.6.3.tar.bz2 && \
    tar -xjvf antragsgruen-4.6.3.tar.bz2 && \
    rmdir /app && \
    mv antragsgruen-4.6.3 /app && \
    rm /app/config/INSTALLING && \
    chown -R application:application /app/web/assets && \
    chown -R application:application /app/runtime && \
    rm antragsgruen-4.6.3.tar.bz2

COPY custom/ /app/
COPY httpd/ /opt/docker/etc/httpd/
