# Stage 1: Build the Flutter web application from scratch
FROM ubuntu:22.04 AS builder

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    wget \
    xz-utils \
    libglu1-mesa \
    && rm -rf /var/lib/apt/lists/*

# Set up a non-root user
RUN useradd -ms /bin/bash flutteruser
USER flutteruser
WORKDIR /home/flutteruser

# Download and install Flutter SDK
ENV FLUTTER_VERSION="3.22.2"
RUN wget "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz" -O flutter.tar.xz && \
    tar xf flutter.tar.xz && \
    rm flutter.tar.xz
ENV PATH="$PATH:/home/flutteruser/flutter/bin"

# Pre-download Flutter artifacts
RUN flutter precache --web

# Set workdir for the app
WORKDIR /home/flutteruser/app

# Copy dependency files and fetch dependencies first to leverage Docker cache
COPY --chown=flutteruser:flutteruser pubspec.yaml pubspec.lock ./
RUN flutter pub get

# Copy the rest of the application source code
COPY --chown=flutteruser:flutteruser . .

# Build the web application
RUN flutter build web --release

# Stage 2: Serve the built application with Nginx
FROM nginx:1.27.0-alpine

# Copy the built web app from the builder stage to the Nginx server directory
COPY --from=builder /home/flutteruser/app/build/web /usr/share/nginx/html

# Copy the custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 to the outside world
EXPOSE 80

# Nginx will be started by default when the container runs
CMD ["nginx", "-g", "daemon off;"]