# Build stage
FROM golang:alpine AS builder
RUN apk add --no-cache git ca-certificates
WORKDIR /go/src/app
COPY . .
RUN go build -o /go/bin/app

# Run stage
FROM scratch
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
WORKDIR /app
COPY --from=builder /go/bin/app /app
EXPOSE 8080
ENTRYPOINT ["./app"]
