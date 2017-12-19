ARG CLI_IMAGE
FROM ${CLI_IMAGE:-builder} as builder

FROM amazeeiolagoon/pr-120-php:7.1-fpm

COPY --from=builder /app /app
