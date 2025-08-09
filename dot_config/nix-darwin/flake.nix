# Initial installation: sudo nix run nix-darwin -- switch --flake ~/.config/nix-darwin
# Subsequent updates: darwin-rebuild switch --flake ~/.config/nix-darwin
# 
# nix-darwin: https://nix-darwin.github.io/nix-darwin/manual/index.html
# home-manager: https://nix-community.github.io/home-manager/options.xhtml
# TODO: Add image2icon from app store
{
  description = "Gatlen's nix-darwin macOS nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-vscode-extensions.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager
    , nix-vscode-extensions, nur }:
    let
      # Import secrets (create secrets.nix based on secrets-template.nix)
      secrets = import "${self}/secrets.nix";

      # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ System Packages ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
      systemPackages = pkgs:
        import "${self}/modules/system-packages.nix" { inherit pkgs; };

      # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Homebrew Configuration ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
      homebrewConfig = import "${self}/modules/homebrew.nix";

      # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ System Defaults ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
      systemDefaults = import "${self}/modules/system-defaults.nix";

      terminalPrograms = pkgs:
        import "${self}/terminal/terminal-programs.nix" { inherit pkgs; };
      # zed-editor.enable = true;
      # sketchybar.enable = true;
      # obs-studio.enable = true;
      # obsidian.enable = true;

      shellConfig =
        import "${self}/terminal/shell-config.nix" { inherit secrets; };

      applicationPrograms = pkgs:
        import "${self}/modules/applications.nix" { inherit pkgs; };

      # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Home Manager Configuration ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
      homeManagerConfig = { pkgs, ... }: {
        home.stateVersion = "25.05";
        home.shellAliases = {
          config = "$EDITOR ~/.config/nix-darwin";
          rebuild = "sudo darwin-rebuild switch --flake ~/.config/nix-darwin";
          upgrade = "sudo determinate-nixd upgrade && topgrade";
        };
        home.shell = {
          enableShellIntegration = true;
          enableZshIntegration = true;
        };

        xdg = {
          enable = true;
          cacheHome = "/Users/gat/.cache";
          configHome = "/Users/gat/.config";
          dataHome = "/Users/gat/.local/share";
        };

        programs = terminalPrograms pkgs // shellConfig
          // applicationPrograms pkgs // {
            vscode = {
              enable = true;
              profiles.default = {
                extensions =
                  import "${self}/vscode-extensions.nix" { inherit pkgs; };
                userSettings = import "${self}/vscode-settings.nix";
              };
            };
          };
      };

      # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Main Darwin Configuration ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
      configuration = { pkgs, ... }: {
        # Core Setup
        imports = [ home-manager.darwinModules.home-manager ];
        nixpkgs.config.allowUnfree = true;
        nixpkgs.hostPlatform = "aarch64-darwin";
        nixpkgs.overlays =
          [ nix-vscode-extensions.overlays.default nur.overlays.default ];

        # Environment
        environment = {
          darwinConfig = "$HOME/.config/nix-darwin";
          pathsToLink = [ "/share/zsh" "/share/bash-completion" ];
          systemPackages = systemPackages pkgs;
          systemPath =
            [ "/Users/gat/.cargo/bin" "/Users/gat/.local/share/../bin" ];
        };

        # System Configuration
        system = systemDefaults // {
          configurationRevision = self.rev or self.dirtyRev or null;
          primaryUser = "gat";
          stateVersion = 5;
        };

        # User Configuration
        users.users.gat = {
          home = "/Users/gat";
          name = "gat";
        };

        # Fonts
        fonts.packages = import "${self}/modules/fonts.nix" { inherit pkgs; };

        # Services
        services.aerospace = {
          enable = true;
          settings = import "${self}/aerospace-config.nix";
        };
        programs.gnupg.agent.enable = true;
        # services.syncthing.enable = true;
        # services.ludusavi.enable = true;
        # services.flameshot.enable = false;

        # Nix Configuration
        nix = {
          enable = false; # Handled by Determinate Nix
          package = pkgs.nix;
          settings."extra-experimental-features" = [ "nix-command" "flakes" ];
        };

        # Homebrew
        homebrew = homebrewConfig;

        # Home Manager
        home-manager = {
          backupFileExtension = "backup";
          useGlobalPkgs = true;
          useUserPackages = true;
          users.gat = homeManagerConfig;
        };
      };

    in {
      darwinConfigurations."gatty" =
        nix-darwin.lib.darwinSystem { modules = [ configuration ]; };
    };
}
