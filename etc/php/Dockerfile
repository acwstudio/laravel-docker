# PHP Version environment variable
ARG PHP_VER_FPM

# PHP Version alpine image to install based on the PHP_VERSION environment variable
FROM php:${PHP_VER_FPM}-fpm-alpine
RUN echo "version $PHP_VERSION"
# Copy composer.lock and composer.json
#COPY composer.lock composer.json /var/www/html/

# Set working directory
WORKDIR /var/www/html

# Install Additional dependencies
RUN apk update && apk add --no-cache \
    build-base shadow nano curl gcc git bash oniguruma-dev libzip-dev gnu-libiconv \
    php7 \
    php7-fpm \
    php7-common \
    php7-pdo \
    php7-pdo_mysql \
    php7-mysqli \
    php7-mcrypt \
    php7-mbstring \
    php7-xml \
    php7-openssl \
    php7-json \
    php7-phar \
    php7-zip \
    php7-gd \
    php7-dom \
    php7-session \
    php7-zlib \
    php7-iconv \
    php7-intl

ARG PHP_VER_FPM

RUN if [ "${PHP_VER_FPM}" = "7.4" ]; then \
   apk update && apk add --no-cache $PHPIZE_DEPS \
   freetype-dev \
   libjpeg-turbo-dev \
   libpng-dev && \
   docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ && \
   docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) gd && \
   docker-php-ext-install sockets; \
fi

RUN if [ "${PHP_VER_FPM}" = "7.2" ]; then \
    apk update && apk add --no-cache $PHPIZE_DEPS \
    freetype \
    libjpeg-turbo-dev \
    libpng-dev && \
    docker-php-ext-configure gd --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ && \
    docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) gd; \
fi

# Install extensions
RUN docker-php-ext-install pdo pdo_mysql zip exif pcntl

RUN pecl install -o -f redis \
&&  rm -rf /tmp/pear \
&&  docker-php-ext-enable redis

ENV LD_PRELOAD="/usr/lib/preloadable_libiconv.so php-fpm7 php"

# Install PHP Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Remove Cache
RUN rm -rf /var/cache/apk/*

# Add UID '1000' to www-data
RUN apk add shadow && usermod -u 1000 www-data && groupmod -g 1000 www-data

# Copy existing application directory permissions
COPY --chown=www-data:www-data . /var/www/html

# Change current user to www
USER www-data

# Expose port 9000 and start php-fpm server
EXPOSE 9000

# Run php-fpm
CMD ["php-fpm"]
