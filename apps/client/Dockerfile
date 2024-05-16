ARG BASE_IMAGE=docker.io/oven/bun:1.1.8
ARG PROD_IMAGE=docker.io/bitnami/nginx:1.24.0

# Base
FROM ${BASE_IMAGE} AS base

WORKDIR /app
COPY ./package.json ./bun.lockb ./


# Install
FROM base AS install

COPY ./ ./
RUN bun install --ignore-scripts


# Dev
FROM base AS dev

COPY --from=install /app/node_modules ./node_modules
COPY ./ ./
ENTRYPOINT [ "bun", "run", "dev" ]


# Build
FROM base AS build

ENV NODE_ENV=production
COPY --from=install /app/node_modules ./node_modules
COPY ./ ./
RUN bun run build


# Prod
FROM ${PROD_IMAGE} AS prod

USER 0
COPY --chown=1001:0 --chmod=770 --from=build /app/dist /opt/bitnami/nginx/html/
COPY --chown=1001:0 --chmod=660 ./nginx/nginx-static.conf /opt/bitnami/nginx/conf/server_blocks/default.conf
COPY --chown=1001:0 ./nginx/entrypoint.sh /docker-entrypoint-initdb.d/load-env.sh
USER 1001
EXPOSE 8080
