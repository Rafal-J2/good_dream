# Step 1: Build the Dart backend using official Dart SDK image
FROM dart:stable AS build

# Set directory inside build container
WORKDIR /app

# Copy pubspec files and download dependencies
COPY pubspec.yaml ./
RUN dart pub get

# Copy all backend source code
COPY . .

# Compile code to a native self-contained executable
RUN dart compile exe bin/main.dart -o bin/server

# Step 2: Create a minimal, secure runtime image
FROM debian:bookworm-slim

# IMPORTANT: Install SSL certificates so that the backend can securely make HTTPS requests to the DeepSeek API
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

# Copy the compiled native server from build stage
COPY --from=build /app/bin/server /app/bin/server

# Expose the default port (used as fallback)
EXPOSE 3400

# Start the compiled server
CMD ["/app/bin/server"]
