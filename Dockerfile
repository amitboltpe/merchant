# Stage 1: Build the Go binary
FROM golang:1.25.3 AS builder

# Set environment variables for Go build
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

# Set the working directory inside container
WORKDIR /app

# Copy go mod files and download dependencies first (for caching)
COPY go.mod go.sum ./
RUN go mod download

# Copy the rest of the project
COPY . .

# Build the binary for the merchant project
RUN go build -o merchant .

# Stage 2: Create a minimal runtime image
FROM debian:bookworm-slim

# Install PostgreSQL client (so app can connect to a PostgreSQL DB)
RUN apt-get update && \
    apt-get install -y --no-install-recommends postgresql-client && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the binary from builder stage
COPY --from=builder /app/merchant .

# Expose port 9091
EXPOSE 9091

# Run the merchant binary
CMD ["./merchant"]
