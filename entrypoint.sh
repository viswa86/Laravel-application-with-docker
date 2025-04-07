#!/bin/sh

# Run database migrations and setup tables
php artisan cache:table
php artisan queue:table
php artisan session:table
php artisan migrate --force

# Set permissions
chmod -R 777 storage bootstrap/cache
chown -R www-data:www-data storage bootstrap/cache

# Start Laravel Server
exec php artisan serve --host=0.0.0.0 --port=8000\
