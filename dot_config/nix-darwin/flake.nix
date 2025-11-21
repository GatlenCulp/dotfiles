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
    tytanic.url = "github:typst-community/tytanic/v0.3.1";
    tytanic.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager
    , nix-vscode-extensions, nur, tytanic }:
    let
      # Import secrets (create secrets.nix based on secrets-template.nix)
      secrets = import "${self}/secrets/secrets.nix";
      systemPackages = pkgs:
        import "${self}/modules/darwin/system-packages.nix" { inherit pkgs; };
      homebrewConfig = import "${self}/modules/darwin/homebrew.nix";
      systemDefaults = import "${self}/modules/darwin/system-defaults.nix";
      terminalPrograms = pkgs:
        import "${self}/modules/home/terminal/terminal-programs.nix" {
          inherit pkgs;
        };
      customSystemPackages = { inputs, pkgs }:
        import "${self}/modules/darwin/custom-system-packages.nix" {
          inherit inputs pkgs;
        };
      # zed-editor.enable = true;
      # sketchybar.enable = true;
      # obs-studio.enable = true;
      # obsidian.enable = true;

      shellConfig = import "${self}/modules/home/terminal/shell-config.nix" {
        inherit secrets;
      };

      applicationPrograms = pkgs:
        import "${self}/modules/home/applications.nix" { inherit pkgs; };

      ruffSettings = import "${self}/modules/home/ruff.nix";

      # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Home Manager Configuration ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
      homeManagerConfig = { pkgs, ... }: {
        home.stateVersion = "25.05";
        home.shellAliases = {
          config = "$EDITOR ~/.config/nix-darwin";
          rebuild = "sudo darwin-rebuild switch --flake ~/.config/nix-darwin --show-trace";
          upgrade = "topgrade";
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
            ruff = {
              enable = true;
              settings = ruffSettings;
            };
          } // {
            vscode = {
              enable = true;
              profiles.default = {
                extensions =
                  import "${self}/modules/home/vscode/vscode-extensions.nix" {
                    inherit pkgs;
                  };
                userSettings =
                  import "${self}/modules/home/vscode/vscode-settings.nix";
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
          systemPackages = (systemPackages pkgs)
            ++ (customSystemPackages { inherit inputs pkgs; });
          systemPath =
            [ "/Users/gat/.cargo/bin" "/Users/gat/.local/share/../bin" ];
        };

        # launchd
        launchd.user.agents = {
          zed-test = {
            command = "${pkgs.zed}/bin/zed";
            serviceConfig = {
              KeepAlive = false;
              RunAtLoad = true;
            };
          };
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
        fonts.packages =
          import "${self}/modules/darwin/fonts.nix" { inherit pkgs; };

        # Services
        services.aerospace = {
          enable = true;
          settings = import "${self}/modules/home/aerospace-config.nix";
        };
        # services.dropbox.enable = true; # Doesn't work? For dropbox cli it seems
        programs.gnupg.agent.enable = true;
        # services.syncthing.enable = true; # Doesn't work for some reason
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
