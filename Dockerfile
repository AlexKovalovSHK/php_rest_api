FROM php:8.2-apache

# Включаем mod_rewrite
RUN a2enmod rewrite

# Копируем приложение
COPY . /var/www/html

# Копируем и делаем исполняемым entrypoint
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Устанавливаем entrypoint
ENTRYPOINT ["docker-entrypoint.sh"]

# Команда по умолчанию
CMD ["apache2-foreground"]