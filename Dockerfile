# PHP Version environment variable
ARG PHP_VERSION

# PHP Version alpine image to install based on the PHP_VERSION environment variable
FROM php:$PHP_VERSION-fpm-alpine

# Application environment variable
ARG APP_ENV
ARG PHP_VERSION_APP

# Remote working directory environment variable
ARG REMOTE_WORKING_DIR

# Install Additional dependencies
RUN apk update && apk add --no-cache $PHPIZE_DEPS \
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
   php7-iconv

RUN if [ "$PHP_VERSION_APP" = "7.4" ]; then \
   apk update && apk add --no-cache $PHPIZE_DEPS \
   freetype-dev \
   libjpeg-turbo-dev \
   libpng-dev && \
   docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ && \
   docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) gd; \
fi

RUN if [ "$PHP_VERSION_APP" = "7.2" ]; then \
    apk update && apk add --no-cache $PHPIZE_DEPS \
    freetype \
    libjpeg-turbo-dev \
    libpng-dev && \
    docker-php-ext-configure gd --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ && \
    docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) gd; \
fi

# Install extensions
RUN docker-php-ext-install pdo pdo_mysql zip exif pcntl

# install xdebug and enable it if the development environment is local
#RUN if [ $APP_ENV = "local" ]; then \
#   pecl install xdebug; \
#   docker-php-ext-enable xdebug; \
#fi;
ENV LD_PRELOAD="/usr/lib/preloadable_libiconv.so php-fpm7 php"

# Install PHP Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Remove Cache
RUN rm -rf /var/cache/apk/*

# Add UID '1000' to www-data
RUN apk add shadow && usermod -u 1000 www-data && groupmod -g 1000 www-data

# Copy existing application directory permissions
COPY --chown=www-data:www-data . $REMOTE_WORKING_DIR

# Change current user to www
USER www-data

# Expose port 9000 and start php-fpm server
EXPOSE 9000

# Run php-fpm
CMD ["php-fpm"]