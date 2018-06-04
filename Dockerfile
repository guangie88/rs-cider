FROM ubuntu:bionic

ENV CARGO_HOME=/opt/.cargo
ENV RUSTUP_HOME=/opt/.rustup
ENV PATH=${CARGO_HOME}/bin:${PATH}

RUN set -x \
    # set up dependencies first
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    cmake \
    curl \
    file \
    git \
    libcurl4 \
    libmysqlclient-dev \
    libpq-dev \
    libsqlite3-dev \
    libssl-dev \
    pkg-config \
    zlib1g-dev \
    # rustup set-up (default is stable)
    && curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path \
    --default-toolchain stable \
    && rustup component add rustfmt-preview \
    # then beta
    && rustup toolchain add beta \
    && rustup component add --toolchain beta rustfmt-preview \
    # then nightly
    && rustup toolchain add nightly \
    && rustup component add --toolchain nightly rustfmt-preview \
    # install clippy (nightly only)
    && cargo +nightly install clippy \
    # install cargo-tarpaulin via stable
    && cargo install cargo-tarpaulin \
    # clean-up
    && apt-get clean \
    && rm ${CARGO_HOME}/bin/rustup \
    && rm -rf ${CARGO_HOME}/registry/* \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /volume
