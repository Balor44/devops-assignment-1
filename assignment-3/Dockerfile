FROM alpine:3.20
RUN apk add --no-cache bash coreutils procps iproute2 iputils bind-tools
COPY app/ /app/
RUN chmod +x /app/*.sh
WORKDIR /app
ENTRYPOINT ["/app/app.sh"]
CMD ["help"]

