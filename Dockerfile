ARG WORDPRESS_VERSION

FROM wordpress:${WORDPRESS_VERSION:-php7.3-fpm}

# for build
ARG NR_LICENSE_KEY
ARG NR_APP_NAME

# update
RUN apt-get -y update

# Memcached client library
RUN apt-get -y install libz-dev libmemcached-dev && \
    yes '' | pecl install memcached redis && \
    rm -rf /tmp/pear && \
    docker-php-ext-enable memcached redis

# New Relic builds at run time
CMD if [ -z "${NR_LICENSE_KEY}" ]; then \
      php-fpm; else \
      export NR_DOWNLOAD="$(curl -s https://download.newrelic.com/php_agent/release/ | grep '\-linux.tar.gz' | perl -pe 's/<.*?>|\t//g')"; \
      curl -L "https://download.newrelic.com/php_agent/release/${NR_DOWNLOAD}" | tar -C /tmp -zx && \
      export NR_INSTALL_USE_CP_NOT_LN=1 && \
      export NR_INSTALL_SILENT=1 && \
      /tmp/newrelic-php*/newrelic-install install && \
      rm -rf /tmp/newrelic-php* /tmp/nrinstall* && \
      sed -i -e "s/\(newrelic.license =\) .*$/\1 \"${NR_LICENSE_KEY}\"/" \
      -e "s/\(newrelic.appname =\) .*$/\1 \"${NR_APP_NAME}\"/" \
      /usr/local/etc/php/conf.d/newrelic.ini && \
      php-fpm; \
    fi
