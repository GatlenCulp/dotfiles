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
          # Core tools
          pkgs.vim
          pkgs.neo-cowsay
          pkgs.devenv
          pkgs.git
          pkgs.gh
          pkgs.pre-commit
          pkgs.bash
          pkgs.zsh
          
          # File operations
          pkgs.eza
          pkgs.bat
          pkgs.xz
          pkgs.gnutar
          
          # Search & Navigation
          pkgs.zoxide
          pkgs.fzf
          pkgs.gnugrep
          
          # System Monitoring
          pkgs.btop
          pkgs.fastfetch
          
          # Network tools
          pkgs.openssh
          pkgs.curl
          
          # Development tools
          pkgs.thefuck
          pkgs.tldr
          
          # Version control
          pkgs.git-lfs
          
          # Terminal tools
          pkgs.tmux
          
          # Shell utilities
          pkgs.shellcheck
          pkgs.shfmt
          
          # Configuration
          pkgs.chezmoi
        ];

      # Use a custom configuration.nix location
      environment.darwinConfig = "$HOME/.config/nix-darwin";

      # Auto upgrade nix package and the daemon service
      services.nix-daemon.enable = false;
      nix = {
        # Determinate systems, don't update nix.
        enable = false;
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
      homebrew = {
        enable = true;
        
        # Separate taps section
        taps = [
          "homebrew/bundle"
          "charmbracelet/tap"
          "mayowa-ojo/tap"
          "noborus/tap"
        ];
        
        # Core brew formulas
        brews = [
          # Core tools
          # "git"  # Using nixpkgs
          # "gh"  # Using nixpkgs
          # "pre-commit"  # Using nixpkgs
          # "bash"  # Using nixpkgs
          # "zsh"  # Using nixpkgs
          "oh-my-posh"
          
          # File operations
          # "eza"  # Using nixpkgs
          # "bat"  # Using nixpkgs
          "tre-command"
          "clipboard"
          # "xz"  # Using nixpkgs
          # "gnu-tar"  # Using nixpkgs
          
          # Search & Navigation
          # "zoxide"  # Using nixpkgs
          # "fzf"  # Using nixpkgs
          # "grep"  # Using nixpkgs
          "ov" # from noborus/tap
          
          # System Monitoring
          # "btop"  # Using nixpkgs
          # "fastfetch"  # Using nixpkgs
          "chmod-cli" # from mayowa-ojo/tap
          
          # Network tools
          "sshs"
          "syncthing"
          "xxh"
          # "openssh"  # Using nixpkgs
          "zrok"
          # "curl"  # Using nixpkgs
          
          # Development tools
          "rich"
          # "thefuck"  # Using nixpkgs
          # "tldr"  # Using nixpkgs
          
          # Version control
          "git-filter-repo"
          # "git-lfs"  # Using nixpkgs
          "bfg"
          "commitizen"
          "czg"
          "check-jsonschema"
          "gitleaks"
          
          # Task running
          "go-task"
          "awscli"
          
          # Terminal tools
          # "tmux"  # Using nixpkgs
          "zellij"
          "freeze" # from charmbracelet/tap
          "vhs"
          "huggingface-cli"
          
          # Shell utilities
          # "shellcheck"  # Using nixpkgs
          # "shfmt"  # Using nixpkgs
          
          # Configuration
          # "chezmoi"  # Using nixpkgs
        ];

        casks = [
          # Existing
          "1password"
          "bartender"
          "brave-browser"
          "fantastical"
          "firefox"
          "karabiner-elements"
          "obsidian"
          "raycast"
          "soundsource"
          "wezterm"
          
          # Terminals
          "warp"
          "ghostty"
          
          # Browsers (additional)
          "google-chrome"
          "tor-browser"
          
          # Media
          "obs"
          "loom"
          "blender"
          "adobe-creative-cloud"
          "clipgrab"
          "vlc"
          
          # Office & Productivity
          "microsoft-office"
          "microsoft-auto-update"
          "notion"
          "notion-calendar"
          "dropbox"
          "cold-turkey-blocker"
          "zotero"
          "lastpass"
          "flux"
          "spotify"
          "applite"
          
          # Communication
          "discord"
          "messenger"
          "whatsapp"
          "zoom"
          "signal"
          "slack"
          
          # Development
          "visual-studio-code"
          "cursor"
          "postman"
          "git-credential-manager"
          "gitkraken"
          "claude"
          "netron"
          
          # Fonts
          "font-fira-code"
          "font-fira-code-nerd-font"
        ];

        # masApps = {
        #   "Drafts" = 1435957248;
        #   "Reeder" = 1529448980;
        #   "Things" = 904280696;
        #   "Timery" = 1425368544;
        # };
      };

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
