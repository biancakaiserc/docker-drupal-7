#!/bin/bash

set -e

# Await database.
while ! nc -q 1 db 3306 </dev/null; do sleep 3; done

echo ""
echo "--------------------------------------"
echo "--------- Database connected ---------"
echo "--------------------------------------"
echo ""

cd /var/www/html/
composer install

echo ""
echo "--------------------------------------"
echo "------ Dependencies Installed --------"
echo "--------------------------------------"
echo ""

# Configure Drupal Settings

# Copy configuration files.
cp /var/www/html/drupal/settings/settings.php /var/www/html/docroot/sites/default/settings.php
chmod -R 777 /var/www/html/docroot/sites/default/settings.php

echo ""
echo "-------- Database Variables ----------"
echo ""
echo "MYSQL_DATABASE: ${MYSQL_DATABASE}"
echo ""
echo "MYSQL_USER: ${MYSQL_USER}"
echo ""
echo "MYSQL_PASSWORD: ${MYSQL_PASSWORD}"
echo ""
echo "MYSQL_HOST: ${MYSQL_HOST}"
echo ""
echo "--------------------------------------"
echo ""

# Configure database connection based on docker-compose env variables.
sed -i "s/{MYSQL_DATABASE}/${MYSQL_DATABASE}/g" /var/www/html/docroot/sites/default/settings.php
sed -i "s/{MYSQL_USER}/${MYSQL_USER}/g" /var/www/html/docroot/sites/default/settings.php
sed -i "s/{MYSQL_PASSWORD}/${MYSQL_PASSWORD}/g" /var/www/html/docroot/sites/default/settings.php
sed -i "s/{MYSQL_HOST}/${MYSQL_HOST}/g" /var/www/html/docroot/sites/default/settings.php

echo ""
echo "--------------------------------------"
echo "--------- Settings Ready -------------"
echo "--------------------------------------"
echo ""

# Creating files, if not exists.
if [ ! -d /var/www/html/docroot/sites/default/files ]
then

  # Create basic files and ensure permissions.
  mkdir -p /var/www/html/docroot/sites/default/files
fi

echo ""
echo "--------------------------------------"
echo "------------ Files Ready -------------"
echo "--------------------------------------"
echo ""

# Ensure permissions are correct.
chmod -R 777 /var/www/html/docroot/sites/default/files

echo ""
echo "------------------------------------"
echo "----- Container ready to work! -----"
echo "------------------------------------"
echo ""

# php:apache default entrypoint
apache2-foreground

exec "$@"
