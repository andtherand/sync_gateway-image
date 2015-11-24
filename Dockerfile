#!/usr/bin/env docker

FROM mychiara/base:1.0.1
MAINTAINER Andy Ruck mychiara+docker at gmail com

RUN apt-get -q update && DEBIAN_FRONTEND=noninteractive && \
        apt-get autoclean && apt-get -qy autoremove && \
        apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV SYNC_VERSION=1.1.1 \
        SYNC_RELEASE_URL=http://packages.couchbase.com/releases/couchbase-sync-gateway
ENV SYNC_PACKAGE=couchbase-sync-gateway-community_$SYNC_VERSION-10_x86_64.deb
#http://packages.couchbase.com/releases/couchbase-sync-gateway/1.1.1/couchbase-sync-gateway-community_1.1.1-10_x86_64.deb

# Install sync_gateway from deb package
RUN wget -N -q $SYNC_RELEASE_URL/$SYNC_VERSION/$SYNC_PACKAGE && \
    #echo "$CB_SHA256  $CB_PACKAGE" | sha256sum -c - && \
    dpkg -i ./$SYNC_PACKAGE && rm -f ./$SYNC_PACKAGE

# add init script for runit
COPY scripts/run /etc/service/couchbase-sync_gateway/run
RUN chmod +x /etc/service/couchbase-sync_gateway/run

COPY scripts/config.json /opt/couchbase-sync-gateway/config.json
RUN chown couchbase:couchbase /opt/couchbase-sync-gateway/config.json

RUN mkdir -p /opt/couchbase-sync-gateway/data

#ENTRYPOINT ["/usr/local/bin/sync_gateway"]
CMD ["/sbin/my_init"]

EXPOSE 4984 4985