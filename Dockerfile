FROM jlesage/baseimage-gui:ubuntu-22.04-v4 AS build

MAINTAINER Bjoern Gruening, bjoern.gruening@gmail.com

RUN apt-get update -y && \
     DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
         ca-certificates \
         wget \
         libgl1 \
         qt5dxcb-plugin && \
     rm -rf /var/lib/apt/lists/*


COPY startapp.sh /startapp.sh
RUN chmod +x /startapp.sh && \
    mkdir -p /app/odv

# Generate and install favicons.
RUN \
    APP_ICON_URL=https://github.com/bgruening/docker-odv/raw/main/odv_logo.png && \
    install_app_icon.sh "$APP_ICON_URL"

# Set the name of the application.
ENV APP_NAME="ODV"

ENV KEEP_APP_RUNNING=0

ENV TAKE_CONFIG_OWNERSHIP=1

# Set environment

ENV JAVA_HOME /opt/jdk

ENV PATH ${PATH}:${JAVA_HOME}/bin

WORKDIR /app/odv
RUN wget https://usegalaxy.eu/static/share/odv_5.6.5_linux-amd64.tar.gz && \
    tar -xf odv_5.6.5_linux-amd64.tar.gz && \
    rm odv_5.6.5_linux-amd64.tar.gz

WORKDIR /config
