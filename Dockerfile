# syntax=docker/dockerfile:1.7

FROM node:20-alpine AS build

WORKDIR /work

RUN corepack enable && corepack prepare pnpm@8.15.9 --activate

COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

COPY tsconfig.json tsconfig.node.json vite.config.ts tailwind.config.ts postcss.config.js ./
COPY scripts ./scripts
COPY src ./src
COPY html ./html
COPY theme ./theme
COPY META-INF ./META-INF

RUN pnpm build

FROM alpine:3.20

LABEL org.opencontainers.image.title="keywind"
LABEL org.opencontainers.image.description="Keywind Keycloak theme init container image"
LABEL org.opencontainers.image.licenses="Apache-2.0"

RUN adduser -D -H -u 1001 -G root keywind

WORKDIR /themes/keywind

COPY --from=build --chown=1001:0 /work/theme ./theme
COPY --from=build --chown=1001:0 /work/META-INF ./META-INF

RUN chmod -R u=rwX,g=rX,o=rX /themes/keywind

USER 1001

CMD ["sh", "-c", "cp -R /themes/keywind/theme/keywind /tmp/keywind && ls -la /tmp/keywind"]
