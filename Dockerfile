# syntax=docker/dockerfile:1

# Alpine is chosen for its small footprint
# compared to Ubuntu
FROM golang:1.19-alpine AS builder

WORKDIR /app

# Download necessary Go modules
COPY go.mod ./
COPY go.sum ./

RUN go mod download

# Copy the go source
COPY . .
RUN go mod tidy
RUN apk add build-base

# Build
RUN CGO_ENABLED=1 GOOS=linux GOARCH=amd64 GO111MODULE=on go build -o telegraf_datagen .


# generate clean, final image
FROM alpine:latest 
RUN apk update && apk add --no-cache net-tools && apk add --no-cache busybox-extras
COPY --from=builder /app/telegraf_datagen .
COPY --from=builder /app/telegraf_datagen.conf .
ENTRYPOINT ["./telegraf_datagen"]