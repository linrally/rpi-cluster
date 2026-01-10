FROM alpine:3.19

RUN apk add --no-cache \
    task \
    msmtp \
    ca-certificates \
    tzdata \
    bash

WORKDIR /app

COPY run.sh /app/run.sh

RUN chmod +x /app/run.sh

RUN mkdir -p /root/.task

ENTRYPOINT ["/app/run.sh"]