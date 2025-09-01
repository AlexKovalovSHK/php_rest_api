FROM php:8.2-apache

# Устанавливаем зависимости для Composer
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libzip-dev \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем расширения PHP
RUN docker-php-ext-install pdo pdo_mysql zip \
    && a2enmod rewrite

# Устанавливаем Composer глобально
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Копируем composer.json и устанавливаем зависимости
COPY composer.json /var/www/html/
WORKDIR /var/www/html
RUN composer install --no-dev --optimize-autoloader

# Копируем приложение
COPY . /var/www/html

# Копируем entrypoint
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Права на data/
RUN chown -R www-data:www-data /var/www/html/data && \
    chmod -R 755 /var/www/html/data

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]