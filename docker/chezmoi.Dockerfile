FROM ubuntu:22.04

# Install Python and curl
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Change the working directory to the `app` directory
WORKDIR /app

# Install using script
CMD ["sh", "-c", "sh -c \"$(curl -fsLS get.chezmoi.io)\" -- init --apply GatlenCulp 2>&1 | tee /app/chezmoi.log"]

# Label associated repo
LABEL org.opencontainers.image.source=https://github.com/GatlenCulp/dotfiles