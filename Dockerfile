# Use a base image that supports GUI applications
FROM jlesage/baseimage-gui:ubuntu-24.04-v4 AS build

# Maintainer information
MAINTAINER Bjoern Gruening, bjoern.gruening@gmail.com

RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        ca-certificates \
        wget \
        unzip \
        zip \
        coreutils \
        libexpat1 \
        qt5dxcb-plugin &&\
    rm -rf /var/lib/apt/lists/*

# Define working directory
WORKDIR /app/odv

# declare a build argument for the ODV version
ARG ODV_VERSION=5.8.2
ENV ODV_VERSION=${ODV_VERSION}

# download and unpack
RUN wget https://usegalaxy.eu/static/share/odv_${ODV_VERSION}_linux-amd64.tar.gz && \
    tar -xf odv_${ODV_VERSION}_linux-amd64.tar.gz && \
    rm odv_${ODV_VERSION}_linux-amd64.tar.gz && \
    rm -f /app/odv/bin_linux-amd64/libexpat.so*

# Copy the start script and ensure it is executable
COPY startapp.sh /startapp.sh
RUN chmod +x /startapp.sh

# Generate and install favicons.
RUN \
    APP_ICON_URL=https://github.com/bgruening/docker-odv/raw/main/odv_logo.png && \
    install_app_icon.sh "$APP_ICON_URL"

# Set the name of the application.
ENV APP_NAME="ODV"

ENV KEEP_APP_RUNNING=0

ENV TAKE_CONFIG_OWNERSHIP=1

# Set environment variables
ENV ODVHOME=/app/odv
ENV JAVA_HOME=/opt/jdk
ENV PATH=${PATH}:${JAVA_HOME}/bin


# Ensure LD_LIBRARY_PATH is set
ENV LD_LIBRARY_PATH=${ODVHOME}/bin_linux-amd64:$LD_LIBRARY_PATH

# Copy and configure service
COPY run /etc/services.d/app/run
RUN chmod +x /etc/services.d/app/run

# Define working directory for config
WORKDIR /config

# Set entrypoint to start the application
CMD ["/startapp.sh"]
