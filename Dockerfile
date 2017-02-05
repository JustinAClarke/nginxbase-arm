FROM armhf/debian

LABEL version "1.0"
LABEL maintainer "justin@fuhrmeister-clarke.com"
LABEL description "A Docker Container for Nginx Based Applications"

RUN apt-get -y update && apt-get install -y nginx tar
RUN mkdir -p /srv/http/

COPY index.html /srv/http/index.html
COPY moby.svg /srv/http/moby.svg

RUN sed -i "s|root /var/www/html|root /srv/http/|g" /etc/nginx/sites-enabled/default

RUN chown www-data:www-data -R /srv/http
RUN chmod g+wrs -R /srv/http

COPY startup.sh /
RUN chmod o+x /startup.sh

EXPOSE 80 443

# ENTRYPOINT ["/usr/sbin/apachectl", "start"]
ENTRYPOINT ["/startup.sh"]
CMD ["/usr/sbin/nginx"]

