# syntax=docker/dockerfile:1
#
# Backstage image of the Argo Workflows playground.
#
# Everything happens in this file: the application is generated with
# @backstage/create-app (new frontend system), the Argo Workflows plugins are
# added, then the backend (which also serves the frontend) is built and packaged.
#
#   docker build -t argo-workflows-playground/backstage .   (from this directory)
#   docker run -p 7007:7007 -e BACKSTAGE_BASE_URL=http://localhost:7007 \
#     -e ARGO_WORKFLOWS_URL=http://argo-workflows-server.argo:2746 \
#     -e ARGO_WORKFLOWS_TOKEN=... argo-workflows-playground/backstage

ARG NODE_VERSION=24

# ---- Stage 1: generate and build the application ------------------------------
FROM node:${NODE_VERSION}-trixie-slim AS build

ARG CREATE_APP_VERSION=0.9.4
ARG ARGO_WORKFLOWS_PLUGIN_VERSION=0.3.1
ARG ARGO_WORKFLOWS_BACKEND_PLUGIN_VERSION=0.2.0

# Build tools for the native modules (better-sqlite3, isolated-vm)
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update \
    && apt-get install -y --no-install-recommends python3 g++ make libsqlite3-dev

USER node
WORKDIR /home/node

# The template pins its own Yarn release (.yarn/releases), the yarn of the image delegates to it
RUN echo backstage | npx --yes @backstage/create-app@${CREATE_APP_VERSION} --path app --skip-install

WORKDIR /home/node/app

# The template refuses packages published less than 3 days ago (npmMinimalAgeGate), except @backstage/*.
# Without a committed lockfile, a fresh @backstage release that pins a just-published dependency would
# break the build: disable the gate for this disposable playground image.
ENV YARN_NPM_MINIMAL_AGE_GATE=0

RUN --mount=type=cache,target=/home/node/.yarn/berry,sharing=locked,uid=1000,gid=1000 \
    yarn install

# Frontend plugin: discovered automatically (app.packages: all in app-config.yaml)
# Backend plugin: registered in packages/backend/src/index.ts
RUN --mount=type=cache,target=/home/node/.yarn/berry,sharing=locked,uid=1000,gid=1000 \
    yarn --cwd packages/app add @backstage-community/plugin-argo-workflows@${ARGO_WORKFLOWS_PLUGIN_VERSION} \
    && yarn --cwd packages/backend add @backstage-community/plugin-argo-workflows-backend@${ARGO_WORKFLOWS_BACKEND_PLUGIN_VERSION} \
    && sed -i "/^backend.start();/i backend.add(import('@backstage-community/plugin-argo-workflows-backend'));" \
       packages/backend/src/index.ts \
    && grep -q plugin-argo-workflows-backend packages/backend/src/index.ts

RUN yarn tsc \
    && yarn build:backend \
    && mkdir packages/backend/dist/skeleton packages/backend/dist/bundle \
    && tar xzf packages/backend/dist/skeleton.tar.gz -C packages/backend/dist/skeleton \
    && tar xzf packages/backend/dist/bundle.tar.gz -C packages/backend/dist/bundle

# ---- Stage 2: runtime image with the production dependencies only -------------
FROM node:${NODE_VERSION}-trixie-slim

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update \
    && apt-get install -y --no-install-recommends libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/*

USER node
WORKDIR /app

COPY --from=build --chown=node:node /home/node/app/.yarn ./.yarn
COPY --from=build --chown=node:node /home/node/app/.yarnrc.yml /home/node/app/backstage.json ./
COPY --from=build --chown=node:node /home/node/app/yarn.lock /home/node/app/package.json /home/node/app/packages/backend/dist/skeleton/ ./

RUN --mount=type=cache,target=/home/node/.yarn/berry,sharing=locked,uid=1000,gid=1000 \
    yarn workspaces focus --all --production

COPY --from=build --chown=node:node /home/node/app/packages/backend/dist/bundle/ ./
COPY --from=build --chown=node:node /home/node/app/app-config.yaml ./
COPY --from=build --chown=node:node /home/node/app/examples ./examples

# Playground configuration: URLs and credentials come from the environment
COPY --chown=node:node files/app-config.playground.yaml ./

ENV NODE_ENV=production
EXPOSE 7007

CMD ["node", "packages/backend", "--config", "app-config.yaml", "--config", "app-config.playground.yaml"]
