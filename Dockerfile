FROM debian:bullseye-slim

ARG BINWALKVER=2.3.3

WORKDIR /tmp

RUN apt update && apt install -y  curl tar wget vim python3 python3-pip \
	&& ln -s /usr/bin/python3 /usr/bin/python

RUN wget -O /tmp/bw.tar.gz https://github.com/ReFirmLabs/binwalk/archive/refs/tags/v${BINWALKVER}.tar.gz \
	&& tar xzvf bw.tar.gz \
	&& cd /tmp/binwalk-${BINWALKVER} \
	&& python3 setup.py install \
	&& CFLAGS=-fcommon ./deps.sh --yes \
	&& rm -rf /tmp/*

RUN useradd -m -u 1000 -s /sbin/nologin appuser \
    && rm -rf -- \
        /var/lib/apt/lists/* \
        /tmp/* /var/tmp/* \
        /root/.cache/pip

# Setup locale. This prevents Python 3 IO encoding issues.
ENV DEBIAN_FRONTEND=teletype \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    PYTHONUTF8="1" \
    PYTHONHASHSEED="random"

VOLUME /home/appuser
WORKDIR /home/appuser
USER appuser

ENTRYPOINT ["binwalk"]
