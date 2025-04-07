#!/bin/sh

# Wait for MySQL to be ready (adjust if needed)
echo "Waiting for MySQL..."
until nc -z -v -w30 mysql 3306
do
  echo "Waiting for database connection..."
  sleep 5
done

# Run artisan commands
php artisan config:clear
php artisan cache:clear
php artisan view:clear

# Generate missing migration files if they don't exist
[ ! -f database/migrations/*create_cache_table.php ] && php artisan cache:table
[ ! -f database/migrations/*create_jobs_table.php ] && php artisan queue:table
[ ! -f database/migrations/*create_sessions_table.php ] && php artisan session:table

# Run all migrations
php artisan migrate --force

# Set permissions
chmod -R 777 storage bootstrap/cache
chown -R www-data:www-data storage bootstrap/cache

# Start Laravel Server
exec php artisan serve --host=0.0.0.0 --port=8000
