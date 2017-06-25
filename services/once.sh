#!/bin/bash
mkdir -p /var/www
echo '<?php phpinfo();' > /var/www/phpinfo.php
chown -R www-data:www-data /var/www
