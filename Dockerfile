FROM php:7.4-cli
RUN apt-get update -y
RUN apt-get upgrade -y


RUN apt-get install -y libonig-dev
RUN apt-get install openssl zip unzip git -y
RUN apt-get install apache2 -y
RUN apt-get install aptitude -y


RUN docker-php-ext-install mysqli pdo pdo_mysql shmop mbstring 

COPY composer.json composer.json
COPY artisan artisan
COPY . .
RUN mkdir /bootstrap/cache
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer --version
RUN composer update

CMD php artisan serve --port=8000

EXPOSE 8000
