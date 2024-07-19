ARG BASE_IMAGE=docker.io/oven/bun:1.1.8
ARG PROD_IMAGE=docker.io/oven/bun:1.1.8-slim

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


# Prod
FROM ${PROD_IMAGE} AS prod

ENV NODE_ENV=production
WORKDIR /app
COPY --chown=bun:root --from=install /app/package.json /app/package.json
COPY --chown=bun:root --from=install /app/node_modules /app/node_modules
COPY ./ ./
USER bun
EXPOSE 8081/tcp
ENTRYPOINT [ "bun", "run", "/app/src/index.ts" ]
