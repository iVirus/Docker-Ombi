FROM ubuntu:xenial

ENV TZ="America/Denver" \
    LANG="en_US.UTF-8"

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /opt/Ombi

RUN apt-get update && \
    apt-get dist-upgrade --yes && \
    apt-get install --yes --no-install-recommends tzdata locales curl ca-certificates libunwind8 libicu55 libcurl3 && \
    locale-gen en_US.UTF-8 && \
    curl --silent --location "https://ci.appveyor.com/api/projects/tidusjar/requestplex/artifacts/linux.tar.gz" | tar xz && \
    apt-get autoremove --yes --purge && \
    apt-get clean && \
    rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ombi/ /etc/ombi/

VOLUME /data

CMD ["/etc/ombi/start.sh"]

EXPOSE 5000
