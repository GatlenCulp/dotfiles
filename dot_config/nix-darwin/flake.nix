# Initial installation: sudo nix run nix-darwin -- switch --flake ~/.config/nix-darwin
# Subsequent updates: darwin-rebuild switch --flake ~/.config/nix-darwin
# 
# nix-darwin: https://nix-darwin.github.io/nix-darwin/manual/index.html
# home-manager: https://nix-community.github.io/home-manager/options.xhtml
# TODO: Add image2icon from app store
{
  description = "Gatlen's nix-darwin macOS nix configuration";

  inputs = {
    nixpkgs-stable-darwin.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nixpkgs.follows = "nixpkgs-stable-darwin";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      # url = "github:nix-community/home-manager/release-25.05";
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tytanic = {
      url = "github:typst-community/tytanic/v0.3.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager
    , nix-vscode-extensions, nur, tytanic, ... }:
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
      accountsConfig = import "${self}/modules/home/accounts.nix";
      customSystemPackages = { inputs, pkgs }:
        import "${self}/modules/darwin/custom-system-packages.nix" {
          inherit inputs pkgs;
        };


      shellConfig = import "${self}/modules/home/terminal/shell-config.nix" {
        inherit secrets;
      };

      applicationPrograms = pkgs:
        import "${self}/modules/home/applications.nix" { inherit pkgs; };

      ruffSettings = import "${self}/modules/home/ruff.nix";
      sketchybarSettings = import "${self}/modules/home/sketchybar.nix";

      # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Home Manager Configuration ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
      homeManagerConfig = { pkgs, ... }: {
        home.stateVersion = "25.05";
        home.enableNixpkgsReleaseCheck = false; # So I can use old nixpkgs with new home-manager. Can't update nixpkgs bc then nix-darwin freaks.
        home.shellAliases = {
          config = "$EDITOR ~/.config/nix-darwin";
          rebuild = "sudo darwin-rebuild switch --flake ~/.config/nix-darwin --show-trace";
          upgrade = "topgrade";
        };
        home.shell = {
          enableShellIntegration = true;
          # Set universally above
          # enableZshIntegration = true;
          # enableNushellIntegration = true;
        };


        accounts = accountsConfig;

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
              # enableMcpIntegration = true; # Error?
              profiles.default = {
                extensions =
                  import "${self}/modules/home/vscode/vscode-extensions.nix" {
                    inherit pkgs;
                  };
                userSettings =
                  import "${self}/modules/home/vscode/vscode-settings.nix";
              };
            };
          } // {
            sketchybar = {
              enable = false;
              config = sketchybarSettings;
              service.enable = true;
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
          # Doesn't work?
          # shell = home-manager.pkgs.nushell;
          shell = pkgs.nushell;
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
        # services.ludusavi.enable = true; # Doesn't exist
        # services.flameshot.enable = false; # Doesn't exist
        # services.gpg-agent = {
        #   enable = true;
        #   enableZshIntegration = true;
        #   enableNushellIntegration = true;
        # };

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
