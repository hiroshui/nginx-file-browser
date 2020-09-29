FROM nginx

ARG password
ARG username

ENV PASSWORD=$password
ENV USERNAME=$username

MAINTAINER Maximilian Krone <maximilian.krone@web.de>

RUN apt-get update && apt-get install -y apt-utils &&\
    apt-get install -y apache2-utils &&\
    mkdir -p /etc/apache2 &&\
    htpasswd -b -c /etc/apache2/.htpasswd ${USERNAME} ${PASSWORD}

ADD default.conf /etc/nginx/conf.d/default.conf
ADD css/ /opt/www/file-browser/css/
ADD image/ /opt/www/file-browser/image/
ADD js/ /opt/www/file-browser/js/
ADD index.html /opt/www/file-browser/

VOLUME /opt/www/files/
EXPOSE 80
