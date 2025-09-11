FROM wordpress:latest

# Copie des plugins et thèmes WordPress personnalisés (si tu en as)
# Assure-toi que ces dossiers existent, sinon commente ces lignes
# COPY plugins/ /var/www/html/wp-content/plugins/
# COPY themes/ /var/www/html/wp-content/themes/

# Tu peux aussi personnaliser des paramètres PHP ou Apache ici si besoin

# Assure-toi que les permissions sont correctes
RUN chown -R www-data:www-data /var/www/html

