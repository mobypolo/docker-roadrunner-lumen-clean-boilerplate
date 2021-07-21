# Build application runtime, image page: <https://hub.docker.com/_/php>
FROM --platform=linux/amd64 php:8.0.5-alpine as runtime
# install composer, image page: <https://hub.docker.com/_/composer>
COPY --from=composer:2.0.12 /usr/bin/composer /usr/bin/composer
#
# Image page: <https://hub.docker.com/r/spiralscout/roadrunner>
COPY --from=spiralscout/roadrunner:2.0.4 /usr/bin/rr /usr/bin/rr

#define your domain for local development
ENV DOMAIN=lm.ru

USER root

WORKDIR /app

ADD --chown=root:root ./composer.json /app/composer.json

RUN docker-php-ext-install -j$(nproc) sockets opcache \
    && composer install \
    && echo -e "\nopcache.enable=1\nopcache.enable_cli=1\nopcache.jit_buffer_size=32M\nopcache.jit=1235\n" >> \
    ${PHP_INI_DIR}/conf.d/docker-php-ext-opcache.PHP_INI_DIR

#update Domain
RUN openssl req -x509 -nodes -days 1095 -newkey rsa:2048 \
    -subj "/C=CA/ST=QC/O=Company, Inc./CN=$DOMAIN" \
    -addext "subjectAltName=DNS:$DOMAIN" \
    -keyout /etc/ssl/private/selfsigned.key \
    -out /etc/ssl/certs/selfsigned.crt \
    && chmod 644 /etc/ssl/private/selfsigned.key

ENTRYPOINT []
CMD ["rr","serve -c /app/rr-conf/.rr.yaml"]
