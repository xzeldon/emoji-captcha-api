FROM rust:1.69.0-slim as builder

ENV CARGO_REGISTRIES_CRATES_IO_PROTOCOL=sparse

WORKDIR /usr/src/emoji-captcha-api

COPY Cargo.toml .
COPY Cargo.lock .
COPY docker_utils/dummy.rs .
RUN sed -i 's|src/main.rs|dummy.rs|' Cargo.toml
RUN cargo build --release
RUN sed -i 's|dummy.rs|src/main.rs|' Cargo.toml

COPY . .
RUN cargo build --release

FROM gcr.io/distroless/cc

COPY --from=builder /usr/src/emoji-captcha-api/target/release/emoji-captcha-api /opt/emoji-captcha-api/
ADD emojis /opt/emoji-captcha-api/emojis
COPY allowed-emojis.txt /opt/emoji-captcha-api

WORKDIR /opt/emoji-captcha-api

ENTRYPOINT [ "./emoji-captcha-api" ]