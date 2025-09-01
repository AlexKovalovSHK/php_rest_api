FROM php:8.2-apache

# Включаем mod_rewrite
RUN a2enmod rewrite

# Копируем файлы
COPY . /var/www/html

# Права на папку data
RUN chown -R www-data:www-data /var/www/html/data && \
    chmod -R 755 /var/www/html/data

EXPOSE 80
CMD ["apache2-foreground"]