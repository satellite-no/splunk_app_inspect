FROM debian:latest

LABEL maintainer="Sean Elliott <sean@mybeda.com>"
LABEL "splunk-appinspect-version"="latest"
ARG DEBIAN_FRONTEND=noninteractive
ENV AppInspectVersion=latest
#ENV TZ=America/New_York

# Prep the environment and install variables.
#RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y \
    lib32z1-dev \
    libmagic-dev\
    libxml2-dev \
    libxslt-dev \
    python-lxml \
    python3-pip \
    wget
RUN pip3 install --upgrade pip setuptools
RUN mkdir -p /home/downloads
RUN mkdir -p /home/splunk_apps

# Download app inspect.
RUN wget https://download.splunk.com/misc/appinspect/splunk-appinspect-latest.tar.gz -P /home/downloads

# Install App inspect
RUN pip3 install --upgrade pip
RUN pip3 install /home/downloads/splunk-appinspect-latest.tar.gz
RUN splunk-appinspect --help
COPY run_appinspect.sh /home/run_appinspect.sh

# ENTRYPOINT splunk-appinspect inspect /home/splunk_apps/target_app.tar.gz --mode precert --included-tags splunk_appinspect --included-tags cloud
ENTRYPOINT /home/run_appinspect.sh