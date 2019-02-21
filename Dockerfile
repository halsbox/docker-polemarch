FROM python:3.6-alpine as base

RUN set -x && apk add --no-cache --virtual .build-deps gcc make libffi-dev musl-dev libc6-compat openldap-dev krb5-dev \
  && pip3 install -U polemarch

FROM python:3.6-alpine

COPY --from=base /root/.cache /root/.cache
RUN set -x \
  && pip3 install -U polemarch \
  && rm -rf /root/.cache \
  && apk add --update --no-cache git sshpass libuuid mailcap \
  && mkdir -p /var/run/polemarch /data

COPY settings.ini /root/settings.ini.dist
COPY start.sh /start.sh

VOLUME ["/data"]

EXPOSE 8080

ENTRYPOINT ["/bin/ash", "/start.sh"]

