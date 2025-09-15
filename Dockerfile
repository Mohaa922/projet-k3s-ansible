FROM wordpress:php8.2-apache

# Copie des fichiers WordPress personnalisés (facultatif)
# COPY ./wordpress /var/www/html/

# Configuration supplémentaire si besoin (plugins, thèmes, etc.)

EXPOSE 80
