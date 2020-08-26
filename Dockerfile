# ----------------------------------
# Pterodactyl Core Dockerfile
# Environment: Source Engine
# Minimum Panel Version: 0.6.0
# ----------------------------------
FROM        ubuntu:18.04

LABEL       author="Pterodactyl Software" maintainer="support@pterodactyl.io"

ENV         DEBIAN_FRONTEND noninteractive
# Install Dependencies
RUN         dpkg --add-architecture i386 \
            && apt-get update \
            && apt-get update && apt-get install -y --no-install-recommends apt-utils \
            && apt-get upgrade -y \
            && apt-get install -y tar curl gcc g++ lib32gcc1 libgcc1 libcurl4-gnutls-dev:i386 libssl1.0.0:i386 libcurl4:i386 lib32tinfo5 libtinfo5:i386 lib32z1 lib32stdc++6 libncurses5:i386 libcurl3-gnutls:i386 iproute2 gdb libsdl1.2debian libfontconfig telnet net-tools netcat \
            && apt -y --no-install-recommends install curl lib32gcc1 ca-certificates libssl1.0.0 libssl-dev \
            && apt-get install -y --no-install-recommends locales \
            && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
            && dpkg-reconfigure --frontend=noninteractive locales \
            && update-locale LANG=en_US.UTF-8 \
            && apt-get install -y --no-install-recommends gpg-agent software-properties-common apt-transport-https multiarch-support curl wget libcompress-raw-zlib-perl \
            && apt-get install -y --no-install-recommends libprotobuf10 \
            && apt-get install -y --no-install-recommends libidn11 \
            && apt-get install -y --no-install-recommends librtmp1 \
            && apt-get install -y --no-install-recommends redis-server \
            && apt-get install -y --no-install-recommends jq \
            && apt-get install -y --no-install-recommends lib32gcc1 \
            && useradd -m -d /home/container container \
            && cd /lib/x86_64-linux-gnu && ln -s libssl.so.1.0.0 libssl.so.10 && ln -s libcrypto.so.1.0.0 libcrypto.so.10

USER        container
ENV         HOME /home/container
ENV         LANG en_US.UTF-8
ENV         LC_ALL en_US.UTF-8
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
