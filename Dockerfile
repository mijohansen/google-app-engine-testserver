FROM google/cloud-sdk:alpine
RUN apk add curl git unzip php-cli php-mbstring php-bcmath php-dom php-json php-openssl php-phar php-tokenizer php-pdo php-curl
RUN apk add php5-cgi php5-bcmath php5-dom php5-json php5-openssl php5-pdo
RUN gcloud components install --quiet \
    app-engine-php \
    app-engine-python \
    cloud-datastore-emulator \
    app-engine-python-extras
RUN curl -sS --silent --show-error https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN composer global require hirak/prestissimo --no-interaction --no-suggest
EXPOSE 5000 8000
CMD dev_appserver.py --port=5000 -A myproject --php_executable_path /usr/bin/php-cgi5 --host=0.0.0.0 --admin_host=0.0.0.0 ./app.yaml

