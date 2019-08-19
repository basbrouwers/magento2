FROM php:7.2-fpm

# Install dependencies
RUN apt-get update \
  && apt-get install -y \
    libfreetype6-dev \ 
    libicu-dev \ 
    libjpeg62-turbo-dev \ 
    libmcrypt-dev \ 
    libpng-dev \ 
    libxslt1-dev \ 
    sendmail-bin \ 
    sendmail \
    ssh \
    sudo

# Configure the gd library
RUN docker-php-ext-configure \
  gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/

# Install required PHP extensions

RUN docker-php-ext-install \
  dom \ 
  gd \ 
  intl \ 
  mbstring \ 
  pdo_mysql \ 
  xsl \ 
  zip \ 
  soap \ 
  bcmath

# Composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer && \
    composer self-update --preview
RUN command -v composer

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_12.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install nodejs -y
RUN npm install npm@6.9.0 -g
RUN command -v node
RUN command -v npm

# Install Xdebug (but don't enable)
#RUN pecl install -o -f xdebug

ENV PHP_MEMORY_LIMIT 2G
ENV PHP_ENABLE_XDEBUG false
ENV MAGENTO_ROOT /usr/share/nginx/html

ENV DEBUG false
ENV UPDATE_UID_GID false

#ADD etc/php-xdebug.ini /usr/local/etc/php/conf.d/zz-xdebug-settings.ini
#ADD etc/mail.ini /usr/local/etc/php/conf.d/zz-mail.ini

#ADD docker-entrypoint.sh /docker-entrypoint.sh

#RUN ["chmod", "+x", "/docker-entrypoint.sh"]

#ENTRYPOINT ["/docker-entrypoint.sh"]

ENV MAGENTO_RUN_MODE developer
ENV UPLOAD_MAX_FILESIZE 64M

#ADD etc/php-fpm.ini /usr/local/etc/php/conf.d/zz-magento.ini

#ADD etc/php-fpm.conf /usr/local/etc/

# Display versions installed
RUN php -v
RUN composer --version
RUN node -v
RUN npm -v

CMD ["php-fpm", "-F"]
