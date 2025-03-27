#!/bin/sh

#commands

php artisan cache:table
php artisan queue:table
php artisan session:table
php artisan migrate

# Run database migrations
#php artisan migrate --force

# Start Laravel Server
php artisan serve --host=0.0.0.0 --port=8000

