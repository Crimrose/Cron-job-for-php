FROM php:7.3-apache
RUN apt-get -y update \
    && apt-get -y upgrade 
# Cron - use supercronic (https://github.com/aptible/supercronic)
ENV SUPERCRONIC_VERSION=0.1.6
ENV SUPERCRONIC_SHA1SUM=c3b78d342e5413ad39092fd3cfc083a85f5e2b75
RUN curl -sSL "https://github.com/aptible/supercronic/releases/download/v${SUPERCRONIC_VERSION}/supercronic-linux-amd64" > "/usr/local/bin/supercronic" \
 && echo "${SUPERCRONIC_SHA1SUM}" "/usr/local/bin/supercronic" | sha1sum -c - \
 && chmod a+rx "/usr/local/bin/supercronic"
COPY mycrontab /etc/crontab/mycrontab 
COPY entrypoint.sh /
RUN chmod a+x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
