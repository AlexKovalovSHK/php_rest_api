FROM php:8.2-apache

# Устанавливаем модуль для MySQL и mod_rewrite
RUN docker-php-ext-install pdo pdo_mysql \
    && a2enmod rewrite

# Устанавливаем Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Копируем composer.json и устанавливаем зависимости
COPY composer.json /var/www/html/
WORKDIR /var/www/html
RUN composer install --no-dev --optimize-autoloader

# Копируем все файлы приложения
COPY . /var/www/html

# Копируем entrypoint и делаем исполняемым
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Права на data/ и .env (если будут)
RUN chown -R www-data:www-data /var/www/html/data \
    && chmod -R 755 /var/www/html/data

# Устанавливаем entrypoint
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]