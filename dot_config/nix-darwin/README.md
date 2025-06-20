# nix-darwin

This will install nix-darwin if you don't already have it.
```bash
nix run nix-darwin -- switch --flake ~/.config/nix-darwin
```
Everything should happen or be imported into `flake.nix`

NixOS inspired setup:
https://github.com/notusknot/dotfiles-nix

And a nix-darwin setup:
https://github.com/heywoodlh/nix-darwin-flake

Add everything from here:
https://github.com/GatlenCulp/macos_setup/tree/main/src/macos

- Setting default apps with Duti
- Set theme
```bash
#!/user/bin/env bash

echo "Setting desktop preferences..."

abs_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# Set wallpaper
osascript -e "tell application 'Finder' to set desktop picture to POSIX file \'${abs_dir}/wallpaper.jpg\'"

# Enable Dark Mode
defaults write -g AppleInterfaceStyle Dark
```
- Install Rosetta
- Bartender settings or smthn