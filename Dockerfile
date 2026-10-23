FROM golang:1.23-bookworm AS build
RUN git clone https://github.com/WhiteDNS/CottenDNS /src
WORKDIR /src
RUN go build -o /out/server ./cmd/server

FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y ca-certificates libc-bin && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY --from=build /out/server /app/server
COPY server_config.toml /app/server_config.toml
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]
