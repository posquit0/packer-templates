#!/usr/bin/env bash

set -euf -o pipefail

KONG_VERSION=0.14.1

# Create a Docker network for Kong
docker network create kong-net

# Run Postgres DB for Kong
docker run -d --name kong-database \
  --restart unless-stopped \
	--network=kong-net \
	-p 5432:5432 \
	-e "POSTGRES_USER=kong" \
	-e "POSTGRES_DB=kong" \
	postgres:9.6
# Run DB migration jobs
docker run --rm \
	--network=kong-net \
	-e "KONG_DATABASE=postgres" \
	-e "KONG_PG_HOST=kong-database" \
	-e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" \
	kong:latest kong migrations up
# Run Kong automatically with Docker
docker run -d --name kong \
  --restart unless-stopped \
	--network=kong-net \
	-e "KONG_DATABASE=postgres" \
	-e "KONG_PG_HOST=kong-database" \
	-e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" \
	-e "KONG_PROXY_ACCESS_LOG=/dev/stdout" \
	-e "KONG_ADMIN_ACCESS_LOG=/dev/stdout" \
	-e "KONG_PROXY_ERROR_LOG=/dev/stderr" \
	-e "KONG_ADMIN_ERROR_LOG=/dev/stderr" \
	-e "KONG_ADMIN_LISTEN=0.0.0.0:8001, 0.0.0.0:8444 ssl" \
	-p 8000:8000 \
	-p 8443:8443 \
	-p 8001:8001 \
	-p 8444:8444 \
	kong:${KONG_VERSION}-alpine
