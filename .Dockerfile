ARG WORDPRESS_VERSION

FROM wordpress:${WORDPRESS_VERSION:-php7.3-fpm}

# for build time
ARG NR_DOWNLOAD
ARG NR_LICENSE_KEY

ENV NR_LICENSE_KEY=${NR_LICENSE_KEY:-REPLACE_WITH_REAL_KEY}
ENV NR_DOWNLOAD=${NR_DOWNLOAD:-newrelic-php5-8.7.0.242-linux.tar.gz}

# update
RUN apt-get -y update

# Memcached client library
RUN apt-get -y install libz-dev libmemcached-dev && \
    pecl install memcached && \
    docker-php-ext-enable memcached

# New Relic
RUN if [ -z "${NR_LICENSE_KEY}" ]; then \
      :; else \
      curl -L "https://download.newrelic.com/php_agent/release/${NR_DOWNLOAD}" | tar -C /tmp -zx && \
      export NR_INSTALL_USE_CP_NOT_LN=1 && \
      export NR_INSTALL_SILENT=1 && \
      /tmp/newrelic-php*/newrelic-install install && \
      rm -rf /tmp/newrelic-php* /tmp/nrinstall*; \
    fi

CMD sed -i -e "s/\(newrelic.license =\) .*$/\1 \"${NR_LICENSE_KEY}\"/" \
    -e "s/\(newrelic.appname =\) .*$/\1 \"${NR_APP_NAME}\"/" \
    /usr/local/etc/php/conf.d/newrelic.ini && php-fpm
