FROM alpine:3.9

# install rclone
RUN apk add --no-cache wget ca-certificates && \
    wget -q https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
    unzip rclone-current-linux-amd64.zip && \
    mv rclone-*-linux-amd64/rclone /usr/bin && \
    rm rclone-current-linux-amd64.zip && \
    rm -rf rclone-current-linux-amd64 && \
    apk del wget

# install entrypoint
ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# defaults env vars
ENV CRON_SCHEDULE="0 0 * * *"
ENV COMMAND="rclone version"

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["crond", "-f"]
