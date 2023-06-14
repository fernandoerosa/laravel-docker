#!/bin/bash

composer update && \
    chown -R www-data:www-data /var/www/storage && \
    php artisan migrate && \
    php artisan storage:link && \
    php-fpm
