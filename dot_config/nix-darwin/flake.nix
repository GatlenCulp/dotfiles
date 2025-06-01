{
  description = "Gatlen's nix-darwin macOS nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };
  
  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, nix-vscode-extensions }:
  let
    configuration = { pkgs, ... }: {
      # Import home-manager module
      imports = [ home-manager.darwinModules.home-manager ];
      
      # Add the overlay for VSCode extensions
      nixpkgs.overlays = [
        nix-vscode-extensions.overlays.default
      ];
      
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
          pkgs.bash
          pkgs.zsh
          # pkgs.pre-commit # Takes too long to build
          
          # File operations
          pkgs.eza
          pkgs.bat
          pkgs.xz
          pkgs.gnutar
          
          # Search & Navigation
          pkgs.zoxide
          pkgs.fzf
          pkgs.gnugrep

          # Window Management
          pkgs.aerospace
          
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
          pkgs.starship
          pkgs.oh-my-zsh
          
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
          
          # VSCode configuration
          programs.vscode = {
            enable = true;
            
            # Extensions from the full VSCode marketplace
            extensions = with pkgs.vscode-marketplace; [
              # Python support
              ms-python.python
              
              # C/C++ support  
              # ms-vscode.cpptools # Doesn't work on aarch64-darwin
              
              # Nix support
              jnoortheen.nix-ide
              
              # Git support
              eamodio.gitlens
              
              # Themes (optional)
              dracula-theme.theme-dracula
            ];
            
            # profiles.gatlen = {
            #   enableUpdateCheck = false;
            # };
          };
        };
      };

      # programs.zsh.oh-my-zsh.enable = true; # doesn't work?

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
          # "homebrew/bundle" # Fails :(
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
          # "oh-my-posh" # Not used
          
          # File operations
          "tre-command"
          "clipboard"
          # "eza"  # Using nixpkgs
          # "bat"  # Using nixpkgs
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
          # "chmod-cli" # from mayowa-ojo/tap # Fails :(
          
          # Network tools
          "sshs"
          "syncthing"
          "xxh"
          "zrok"
          # "openssh"  # Using nixpkgs
          # "curl"  # Using nixpkgs
          
          # Development tools
          "rich"
          # "thefuck"  # Using nixpkgs
          # "tldr"  # Using nixpkgs
          
          # Version control
          "git-filter-repo"
          "bfg"
          "commitizen"
          "czg"
          "check-jsonschema"
          "gitleaks"
          # "git-lfs"  # Using nixpkgs
          
          # Task running
          "go-task"
          "awscli"
          
          # Terminal tools
          "zellij"
          # "freeze" # from charmbracelet/tap # Fails :(
          "vhs"
          "huggingface-cli"
          # "tmux"  # Using nixpkgs
          
          # Shell utilities
          # "shellcheck"  # Using nixpkgs
          # "shfmt"  # Using nixpkgs
          
          # Configuration
          # "chezmoi"  # Using nixpkgs
        ];

        casks = [
          # Existing
          # "1password" # I don't use this
          "bartender"
          "brave-browser"
          # "fantastical" # I don't remember what this is
          "firefox"
          # "karabiner-elements" # I don't remember what this is
          "obsidian"
          "raycast"
          # "soundsource" # Idk what this is
          # "wezterm" # Idk what this is
          
          # Terminals
          # "warp"
          # "ghostty"
          
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
          # "cold-turkey-blocker" # Requires rosetta 2 to be installed
          "zotero"
          "lastpass"
          "flux"
          "spotify"
          # "applite" # I don't remember what this is
          
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
      system.startup.chime = false; # Disable startup chime
      system.defaults = {
        dock = {
          # autohide = true;
          orientation = "left";
          show-process-indicators = true;
          show-recents = false;
          expose-animation-duration = 0.05;
          # autohide-delay = 0.0; # I don't remember what this is
          # static-only = true; # Only show apps in the dock.
          # appswitcher-all-displays = false;
          tilesize = 24;
          largesize = 32;
          # magnification = true;
          minimize-to-application = true;

        };
        finder = {
          AppleShowAllExtensions = true;
          AppleShowAllFiles = true; # Show hidden files
          CreateDesktop = false; # Show icons on desktop
          ShowPathbar = true; # Show path breadcrumbs
          FXEnableExtensionChangeWarning = false;
          FXPreferredViewStyle = "clmv"; # Column view
          QuitMenuItem = true; # Allow quitting of finder
        };
        menuExtraClock = {
          Show24Hour = true;
          # ShowDate = true;
        };
        controlcenter = {
          BatteryShowPercentage = false;
          Bluetooth = false;
          Display = false; # Screen brightness
          FocusModes = false; # Focus modes
          Sound = false; # Sound

        };
        NSGlobalDomain = {
          AppleICUForce24HourTime = true;
          AppleShowAllFiles = true; # Show hidden files
          AppleShowAllExtensions = true; # Show file extensions
          AppleInterfaceStyle = "Dark"; # Dark mode
          # AppleKeyboardUIMode = 3; # I don't remember what this is
          # "com.apple.keyboard.fnState" = true; # I don't remember what this is
        };
      };
      # WindowManager = {
        # EnableStandardClickToShowDesktop = false;
      # };

      # The platform the configuration will be used on
      nixpkgs.hostPlatform = "aarch64-darwin";

      # Allow unfree packages (for VSCode)
      nixpkgs.config.allowUnfree = true;
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake ~/.config/nix-darwin#gatty
    # sudo has some issues
    darwinConfigurations."gatty" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
