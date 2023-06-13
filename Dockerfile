# Define a imagem base
FROM php:7.4-fpm

# Instala dependências do sistema operacional
RUN apt-get update && apt-get install -y \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Instala extensões do PHP necessárias
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Define o diretório de trabalho dentro do container
WORKDIR /var/www

# Copia os arquivos do projeto para o diretório de trabalho
COPY . /var/www

# Instala as dependências do Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instala as dependências do projeto usando o Composer
RUN composer install --no-interaction

# Define o usuário do PHP-FPM como "www-data"
RUN chown -R www-data:www-data /var/www/storage

# Define a porta que o container deve expor
EXPOSE 9000

# Executa o servidor PHP-FPM
CMD ["php-fpm"]
