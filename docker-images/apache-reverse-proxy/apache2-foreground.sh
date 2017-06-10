#!/bin/bash
set -e

# Set ip addresses
CONF_FILE="/etc/apache2/sites-available/001-reverse-proxy.conf"

sed -i "s/{{ip_express_dynamic}}/$IP_EXPRESS_DYNAMIC/g" $CONF_FILE
sed -i "s/{{ip_apache_static}}/$IP_APACHE_STATIC/g" $CONF_FILE

# Start apache2
apache2 -DFOREGROUND