# `rs-cider`

Dockerfile to build Rust + Cargo with useful formatting, linting and coverage
tools in stable, beta and nightly.

Docker Hub link: <https://hub.docker.com/r/guangie88/rs-cider>

[![Build Status](https://travis-ci.org/guangie88/rs-cider.svg?branch=master)](https://travis-ci.org/guangie88/rs-cider)

## Description

The purpose of the Docker image is to create a "Swiss Army knife" for automated
CI/CD purposes for Rust environment.

## Included stuff

- `rustfmt-preview` (`cargo fmt`) on all stable, beta, nightly
  - Link: <https://github.com/rust-lang-nursery/rustfmt>
  - Installed via `rustup component add rustfmt-preview`
  - Stable command:
    - `cargo fmt`
  - Beta command:
    - `cargo +beta fmt`
  - Nightly command:
    - `cargo +nightly fmt`
- `cargo clippy` only on nightly
  - Link: <https://github.com/rust-lang-nursery/rust-clippy>
  - Installed via `cargo +nightly install clippy`
  - Command:
    - `cargo clippy`
- `cargo tarpaulin` via stable
  - Link: <https://github.com/xd009642/tarpaulin>
  - Installed via `cargo install cargo-tarpaulin`
  - Command:
    - `cargo tarpaulin`

## Fun fact

The short form `rs-cider` is actually a
[_portmanteau_](https://en.wikipedia.org/wiki/Portmanteau) for Rust
**CI**/C**D**-**er**, where CI/CD stands for continuous integration and
continuous delivery, and the "-er" is similar to do-er, play-er, mak-er, etc.
