FROM alpine:edge

WORKDIR /var/www/html/

# Essentials
RUN echo "UTC" > /etc/timezone
RUN apk update && apk add --no-cache zip unzip curl sqlite nginx supervisor

# Installing PHP
RUN apk add --no-cache php8 \
    php8-common \
    php8-fpm \
    php8-pdo \
    php8-opcache \
    php8-zip \
    php8-ctype \
    php8-bcmath \
    php8-phar \
    php8-iconv \
    php8-cli \
    php8-curl \
    php8-openssl \
    php8-mbstring \
    php8-tokenizer \
    php8-fileinfo \
    php8-json \
    php8-xml \
    php8-posix \
    php8-pcntl \
    php8-xmlwriter \
    php8-simplexml \
    php8-dom \
    php8-pdo_mysql \
    php8-pdo_sqlite \
    php8-tokenizer \
    php8-pecl-redis && \
    apk add --no-cache php8-pecl-swoole --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing

RUN ln -sf /usr/bin/php8 /usr/bin/php

# Installing composer
RUN curl -s https://getcomposer.org/installer | php

# Configure supervisor
RUN mkdir -p /etc/supervisor.d/
COPY .docker/supervisord.ini /etc/supervisor.d/supervisord.ini

# Configure PHP
RUN mkdir -p /run/php/
RUN touch /run/php/php8.0-fpm.pid

RUN sed -i 's/^variables_order=.*/variables_order = EGPCS/' /etc/php8/php.ini

# Configure nginx
COPY .docker/nginx.conf /etc/nginx/

RUN mkdir -p /run/nginx/
RUN touch /run/nginx/nginx.pid

RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

# Building process
COPY composer.* .
RUN php composer.phar install --no-dev --optimize-autoloader --no-scripts
COPY --chown=nobody:nobody . .
RUN chown -R nobody:nobody /var/www/html/storage

EXPOSE 80
CMD ["supervisord", "-c", "/etc/supervisor.d/supervisord.ini"]
