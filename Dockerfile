FROM phusion/baseimage:0.9.22

RUN apt-get update -y && \ 
    apt-get install -y net-tools curl software-properties-common --no-install-recommends && \
    apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449 && \
    add-apt-repository "deb http://mirror.yourwebhoster.eu/hhvm/ubuntu xenial main" && \
    apt-get update -y && \
    apt-get install hhvm -y --no-install-recommends && \
    rm -rf /var/cache/apt/archives /var/lib/apt/lists/* && \
    apt-get clean -y && \ 
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -sS https://getcomposer.org/installer | hhvm --php -- --install-dir=/usr/local/bin --filename=composer

ADD default/www/phpinfo.php /var/www/phpinfo.php

ADD default/hhvm/server.ini /etc/hhvm/server.ini
RUN touch /etc/hhvm/site.ini

RUN mkdir -p /etc/service/hhvm
COPY services/hhvm.sh /etc/service/hhvm/run
RUN chmod +x /etc/service/hhvm/run

#RUN cd /var/www/public && composer install

RUN mkdir -p /etc/my_init.d
# COPY ./services/once.sh /etc/my_init.d/once.sh
# RUN chmod +x /etc/my_init.d/once.sh

EXPOSE 8080

CMD ["/sbin/my_init"]