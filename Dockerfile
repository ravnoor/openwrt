FROM docker.io/debian:trixie

ARG UID=1000
ARG GID=1000

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash bc binutils bison build-essential ca-certificates ccache \
    device-tree-compiler file flex gawk gettext git \
    help2man libelf-dev liblzma-dev libncurses-dev libssl-dev \
    patch perl pkg-config python3 python3-dev python3-setuptools \
    rsync subversion swig time u-boot-tools unzip \
    wget xsltproc xxd xz-utils zlib1g-dev zstd \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd --gid "${GID}" builder \
    && useradd --uid "${UID}" --gid "${GID}" \
       --create-home --shell /bin/bash builder \
    && mkdir -p /work \
    && chown builder:builder /work

USER builder
ENV HOME=/home/builder
ENV CCACHE_DIR=/work/ccache

WORKDIR /work
CMD ["/bin/bash"]
