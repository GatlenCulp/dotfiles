# nix-darwin

This will install nix-darwin if you don't already have it.

```bash
nix run nix-darwin -- switch --flake ~/.config/nix-darwin
```

Everything should happen or be imported into `flake.nix`

<!-- - `darwin.nix` -- nix-darwin configuration (Mac App Store apps,  Homebrew, etc.) -->

<!-- This will also build if not already existed.
darwin-rebuild switch --flake ~/.config/nix-darwin#gatty-2 -->

NixOS inspired setup:
https://github.com/notusknot/dotfiles-nix

And a nix-darwin setup:
https://github.com/heywoodlh/nix-darwin-flake
