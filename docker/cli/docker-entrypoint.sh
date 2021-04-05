#!/bin/sh
set -e

# If vendor directory does not exist, then it looks like we need to run composer
# install.
if [ ! -d /var/www/html/vendor ]; then
  composer install -vvv
fi

# Initialise a local settings file if we haven't already.
if [ ! -f /var/www/html/web/sites/default/settings.local.php ]; then
  chmod u+w /var/www/html/web/sites/default
  cp /usr/local/init/dev.default.settings.local.php /var/www/html/web/sites/default/settings.local.php
  chmod u-w /var/www/html/web/sites/default
fi

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
  set -- php-fpm "$@"
fi

exec "$@"
