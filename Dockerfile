FROM ubuntu:bionic

ENV CARGO_HOME=/opt/.cargo
ENV RUSTUP_HOME=/opt/.rustup
ENV PATH=${CARGO_HOME}/bin:${PATH}

ARG CARGO_TARPAULIN_VERS="0.6.6"

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
    && rustup component add clippy-preview rustfmt-preview \
    # then beta
    && rustup toolchain add beta \
    && rustup component add --toolchain beta clippy-preview rustfmt-preview \
    # then nightly
    && rustup toolchain add nightly \
    && rustup component add --toolchain nightly clippy-preview rustfmt-preview \
    # install cargo-tarpaulin via stable
    # see: https://github.com/xd009642/tarpaulin/commit/651be48104c700b76b1ec61b9bb72df1b21cfd8c#diff-04c6e90faac2675aa89e2176d2eec7d8
    # see: https://github.com/rust-lang/cargo/issues/6015, publish-lockfile currently requires nightly, so we fix the version for now
    && RUSTFLAGS="--cfg procmacro2_semver_exempt" cargo +stable install cargo-tarpaulin --vers "=${CARGO_TARPAULIN_VERS}" \
    # install diesel_cli via stable
    && cargo +stable install diesel_cli \
    # clean-up
    && apt-get clean \
    && rm ${CARGO_HOME}/bin/rustup \
    && rm -rf ${CARGO_HOME}/registry/* \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /volume
