{
  description = "Gatlen's nix-darwin macOS nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let
    configuration = { pkgs, ... }: {
      # Import home-manager module
      imports = [ home-manager.darwinModules.home-manager ];
      
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [
          pkgs.vim
          pkgs.neo-cowsay
          pkgs.devenv
        ];

      # Use a custom configuration.nix location
      environment.darwinConfig = "$HOME/.config/nix-darwin";

      # Auto upgrade nix package and the daemon service
      services.nix-daemon.enable = true;
      nix = {
        package = pkgs.nix;
        settings = {
          "extra-experimental-features" = [
            "nix-command"
            "flakes"
          ];
        };
      };

      # Create /etc/zshrc that loads the nix-darwin environment
      programs = {
        gnupg.agent.enable = true;
        zsh.enable = true;
      };

      # Set Git commit hash for darwin-version
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # User running nix-darwin
      users.users.gat = {
        name = "gat";
        home = "/Users/gat";
      };
      
      # Home Manager configuration
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.gat = { pkgs, ... }: {
          home.stateVersion = "24.11";
          # Add your home-manager configuration here
          
          # Git configuration (moved from system level to home-manager)
          programs.git = {
            enable = true;
            userEmail = "GatlenCulp@gmail.com";
            userName = "GatlenCulp";
          };
        };
      };

      # Used for backwards compatibility, please read the changelog before changing
      system.stateVersion = 5;

      # Font configuration - updated to use packages instead of fonts
      fonts.packages = [
        pkgs.monaspace
      ];

      # Homebrew configuration
      # homebrew = {
      #   enable = true;

      #   casks = [
      #     "1password"
      #     "bartender"
      #     "brave-browser"
      #     "fantastical"
      #     "firefox"
      #     "karabiner-elements"
      #     "obsidian"
      #     "raycast"
      #     "soundsource"
      #     "wezterm"
      #   ];

        # masApps = {
        #   "Drafts" = 1435957248;
        #   "Reeder" = 1529448980;
        #   "Things" = 904280696;
        #   "Timery" = 1425368544;
        # };
      # };

      # System defaults
      system.defaults = {
        dock = {
          autohide = true;
          orientation = "left";
          show-process-indicators = false;
          show-recents = false;
          static-only = true;
        };
        finder = {
          AppleShowAllExtensions = true;
          ShowPathbar = true;
          FXEnableExtensionChangeWarning = false;
        };
        NSGlobalDomain = {
          AppleKeyboardUIMode = 3;
          "com.apple.keyboard.fnState" = true;
        };
      };

      # The platform the configuration will be used on
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#gatty-2
    darwinConfigurations."gatty-2" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
