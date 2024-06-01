# BUILD ARGS
ARG SOURCE_IMAGE="base"
ARG SOURCE_SUFFIX="-nvidia"
ARG SOURCE_TAG="latest"

# SOURCE IMAGE
FROM ghcr.io/ublue-os/${SOURCE_IMAGE}${SOURCE_SUFFIX}:${SOURCE_TAG}

# MODIFICATIONS
COPY build.sh /tmp/build.sh
RUN mkdir -p /var/lib/alternatives && \
    /tmp/build.sh && \
    ostree container commit
