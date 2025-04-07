# Use official PHP image with necessary extensions
FROM php:8.3-cli

# Set working directory
WORKDIR /var/www

# Install system dependencies & MySQL client
RUN apt-get update && apt-get install -y \
    default-mysql-client \
    zip unzip \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo_mysql gd \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy application files
COPY . .

# Set permissions for storage and cache
RUN chmod -R 777 storage bootstrap/cache && \
    chown -R www-data:www-data storage bootstrap/cache

# Install Laravel dependencies
RUN composer install --no-dev --optimize-autoloader

#ENTRYPOINT ["php", "artisan"]

#CMD ["sh", "-c", "php artisan migrate --force && php artisan serve --host=0.0.0.0 --port=8000"]


# Copy and set entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

#Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]
