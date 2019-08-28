FROM node:8-stretch

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Tell npm to display only warnings and errors
ENV NPM_CONFIG_LOGLEVEL warn

# Disable composer interaction, and root user and xdebug warnings
ENV COMPOSER_NO_INTERACTION 1
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_DISABLE_XDEBUG_WARN 1

ADD / /

RUN /scripts/install-essentials.sh
RUN /scripts/install-python.sh
RUN /scripts/install-pip.sh
#RUN /scripts/install-aws-cli
RUN /scripts/install-node-tools.sh
RUN /scripts/install-php72.sh
RUN /scripts/install-composer.sh

# Show versions
RUN node --version && \
    npm --version && \
    yarn --version && \
    php --version && \
    composer --version && \
    php -m
