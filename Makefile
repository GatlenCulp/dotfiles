.PHONY: test generate-install install-by-script install docker docker-build docker-shell docker-test all clean

# Default target
all: test

# None
clean:
	# TODO

# Test target that runs chezmoi doctor and builds docker-compose
test:
	chezmoi doctor
	# TODO: Add docker build

# Install chezmoi by downloading script
install-by-script:
	# TODO

# Install chezmoi the recommended way
install: 
	sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply GatlenCulp

# Generate install.sh script
generate-install:
	chezmoi generate install.sh > install.sh
	chmod a+x install.sh
	echo install.sh >> .chezmoiignore
	git add install.sh .chezmoiignore
	git commit -m "chore(install): Update install.sh"

# Generate and run docker image for testing
docker-build:
	docker build -t chezmoi-test -f ./docker/chezmoi.Dockerfile .

# Run an interactive shell in the container
docker-shell: docker-build
	docker run -it chezmoi-test /bin/bash

# Run the chezmoi test
docker-test: docker-build
	docker run -it chezmoi-test sh -c 'sh -c "$$(curl -fsLS get.chezmoi.io)" -- init --apply GatlenCulp && eza || exit 1'

# Build and run interactive shell (default)
docker: docker-shell