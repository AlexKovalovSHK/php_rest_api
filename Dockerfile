FROM php:8.2-apache

# Включаем mod_rewrite
RUN a2enmod rewrite

# Копируем приложение
COPY . /var/www/html

# Копируем entrypoint
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Права (на всякий случай — entrypoint всё равно изменит)
RUN chown -R www-data:www-data /var/www/html/data && \
    chmod -R 755 /var/www/html/data

# Устанавливаем entrypoint
ENTRYPOINT ["docker-entrypoint.sh"]

# Команда по умолчанию
CMD ["apache2-foreground"]