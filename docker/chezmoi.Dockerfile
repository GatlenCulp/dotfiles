# Use Ubuntu base image, note that Linuxbrew does not support arm, must run with --platform=linux/amd64
FROM ubuntu:25.04

# Install Python and curl
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    ca-certificates \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Change the working directory to the `app` directory
WORKDIR /app

# Install chezmoi and apply dotfiles
# RUN sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply GatlenCulp

# You can keep CMD for any commands you want to run when the container starts
CMD ["bash"]

# Label associated repo
LABEL org.opencontainers.image.source=https://github.com/GatlenCulp/dotfiles
