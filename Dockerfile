FROM debian:jessie

LABEL maintainer "opsxcq@strm.sh"
LABEL maintainer "simon@linosec.lu"

# Base packages
RUN apt-get update && \
    apt-get -y install \
    git \
    curl \
    python python-yaml python-beautifulsoup python-pip

# Clone pystemon repository
RUN cd / && \
    git clone https://github.com/opsxcq/pystemon && \
    cd pystemon && \
    sed -i '1 i\import redis' pystemon.py && \
    rm -Rf .git

RUN pip install redis

COPY main.sh /main.sh

# All Pastes 
VOLUME /pystemon/pystemon/archive

# Alerts
VOLUME /pystemon/pystemon/alerts

WORKDIR /pystemon

ENTRYPOINT ["/main.sh"]
