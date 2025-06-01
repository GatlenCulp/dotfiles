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
          pkgs.neovim
          pkgs.neo-cowsay
          pkgs.devenv
          pkgs.git
          pkgs.gh
          pkgs.bash
          pkgs.zsh
          pkgs.nushell
          # # pkgs.pre-commit # Takes too long to build
          
          # # File operations
          pkgs.eza
          pkgs.bat
          pkgs.xz
          pkgs.gnutar
          
          # # Search & Navigation
          pkgs.zoxide
          pkgs.fzf
          pkgs.gnugrep

          # # Window Management
          pkgs.aerospace
          
          # # System Monitoring
          pkgs.btop
          pkgs.fastfetch
          
          # # Network tools
          pkgs.openssh
          pkgs.curl
          pkgs.wireshark
          pkgs.tcpflow
          # pkgs.tcptrace
          pkgs.tcpreplay
          pkgs.socat
          pkgs.openvpn
          
          # # Development tools
          pkgs.thefuck
          pkgs.tldr
          
          # # Version control
          pkgs.git-lfs
          # # pkgs.pre-commit # Takes too long to build
          
          # # Terminal tools
          pkgs.tmux
          pkgs.starship
          # pkgs.oh-my-zsh # Now managed via programs.zsh.ohMyZsh
          pkgs.zsh-autosuggestions
          pkgs.zsh-syntax-highlighting
          pkgs.bash-completion
          
          # # Shell utilities
          pkgs.shellcheck
          pkgs.shfmt
          
          # # Configuration
          pkgs.chezmoi

          # # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Programming Languages ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
          
          # # System Programming
          # pkgs.rust
          pkgs.go
          
          # # Web Development
          # pkgs.nodejs
          # pkgs.typescript
          
          # Scripting Languages
          # pkgs.php
          pkgs.ruby
          # pkgs.perl
          # pkgs.lua
          # pkgs.luajit
          
          # # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Python Development ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
          
          # # Package Management & Tools
          pkgs.python3
          pkgs.uv
          
          # # Quality Assurance
          pkgs.pylint
          pkgs.ruff
          
          # # Project Tools
          # pkgs.cookiecutter
          
          # # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Document & Text Processing ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
          
          # # Markdown & Documentation
          # pkgs.pandoc
          
          # # Configuration Formats
          # pkgs.taplo # TOML toolkit
          
          # # Code Formatting
          # # pkgs.prettier
          # # pkgs.tidy-html5
          
          # # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Databases ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
          
          # pkgs.postgresql_16
          # pkgs.sqlite
          
          # # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Container & DevOps ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
          
          # # pkgs.kubectl
          
          # # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Development Tools ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
          
          # # pkgs.jupyterlab
          
          # # Task Runners & Build Tools
          # pkgs.go-task
          
          # # API & Testing
          # # pkgs.awscli
          
          # # GitHub Actions
          # pkgs.act
          # pkgs.actionlint
          
          # # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Security & Penetration Testing ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
          
          # # Network Security
          # pkgs.aircrack-ng
          # pkgs.nmap
          
          # # Password Tools
          # pkgs.hydra
          # pkgs.john
          
          # # SQL Security
          # pkgs.sqlmap
          
          # # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ System Utilities ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
          
          # # Archive & Compression
          # pkgs.brotli
          
          # Math & Science
          # pkgs.gambit
          
        ];

      # Use a custom configuration.nix location
      environment.darwinConfig = "$HOME/.config/nix-darwin";

      # Auto upgrade nix package and the daemon service
      # services.nix-daemon.enable = false;


      # Aerospace window manager configuration
      services.aerospace = {
        enable = true;
        settings = {
          # You can use it to add commands that run after login to macOS user session.
          # 'start-at-login' needs to be 'true' for 'after-login-command' to work
          after-login-command = [];

          # You can use it to add commands that run after AeroSpace startup.
          # 'after-startup-command' is run after 'after-login-command'
          after-startup-command = [];

          # Start AeroSpace at login
          # start-at-login = true;

          # Normalizations. See: https://nikitabobko.github.io/AeroSpace/guide#normalization
          enable-normalization-flatten-containers = true;
          enable-normalization-opposite-orientation-for-nested-containers = true;

          # See: https://nikitabobko.github.io/AeroSpace/guide#layouts
          # The 'accordion-padding' specifies the size of accordion padding
          # You can set 0 to disable the padding feature
          accordion-padding = 50;

          # Possible values: tiles|accordion
          default-root-container-layout = "tiles";

          # Possible values: horizontal|vertical|auto
          # 'auto' means: wide monitor (anything wider than high) gets horizontal orientation,
          #               tall monitor (anything higher than wide) gets vertical orientation
          default-root-container-orientation = "auto";

          # Mouse follows focus when focused monitor changes
          # Drop it from your config, if you don't like this behavior
          # See https://nikitabobko.github.io/AeroSpace/guide#on-focus-changed-callbacks
          # See https://nikitabobko.github.io/AeroSpace/commands#move-mouse
          # Fallback value (if you omit the key): on-focused-monitor-changed = []
          on-focused-monitor-changed = ["move-mouse monitor-lazy-center"];

          # You can effectively turn off macOS "Hide application" (cmd-h) feature by toggling this flag
          # Useful if you don't use this macOS feature, but accidentally hit cmd-h or cmd-alt-h key
          # Also see: https://nikitabobko.github.io/AeroSpace/goodies#disable-hide-app
          automatically-unhide-macos-hidden-apps = true;

          # Possible values: (qwerty|dvorak)
          # See https://nikitabobko.github.io/AeroSpace/guide#key-mapping
          key-mapping = {
            preset = "qwerty";
          };

          # Gaps between windows (inner-*) and between monitor edges (outer-*).
          gaps = {
            inner = {
              horizontal = 5;
              vertical = 5;
            };
            outer = {
              left = 5;
              bottom = 5;
              top = 5;
              right = 5;
            };
          };

          # 'main' binding mode declaration
          # See: https://nikitabobko.github.io/AeroSpace/guide#binding-modes
          # 'main' binding mode must be always presented
          mode.main.binding = {
            # See: https://nikitabobko.github.io/AeroSpace/commands#exec-and-forget
            # You can uncomment the following lines to open up terminal with alt + enter shortcut (like in i3)
            alt-enter = ''exec-and-forget osascript -e '
tell application "Ghostty"
    do script
    activate
end tell'
'';

            # See: https://nikitabobko.github.io/AeroSpace/commands#layout
            alt-slash = "layout tiles horizontal vertical";
            alt-comma = "layout accordion horizontal vertical";

            # See: https://nikitabobko.github.io/AeroSpace/commands#focus
            alt-h = "focus left";
            alt-j = "focus down";
            alt-k = "focus up";
            alt-l = "focus right";

            # See: https://nikitabobko.github.io/AeroSpace/commands#move
            alt-shift-h = "move left";
            alt-shift-j = "move down";
            alt-shift-k = "move up";
            alt-shift-l = "move right";

            # See: https://nikitabobko.github.io/AeroSpace/commands#resize
            alt-shift-minus = "resize smart -50";
            alt-shift-equal = "resize smart +50";

            # WORKSPACES - Organized by column-topics (0-9)

            # 01-🏠_Common: Spotify, Calendar, Terminal, ex.
            alt-1 = "workspace 1";
            alt-q = "workspace q";
            alt-shift-1 = "move-node-to-workspace 1";
            alt-shift-q = "move-node-to-workspace q";

            # 02-📊_METR
            alt-2 = "workspace 2";
            alt-w = "workspace w";
            alt-shift-2 = "move-node-to-workspace 2";
            alt-shift-w = "move-node-to-workspace w";

            # 03-🤖_MAIA
            alt-3 = "workspace 3";
            alt-e = "workspace e";
            alt-shift-3 = "move-node-to-workspace 3";
            alt-shift-e = "move-node-to-workspace e";

            # 04-🎓_School
            alt-4 = "workspace 4";
            alt-r = "workspace r";
            alt-shift-4 = "move-node-to-workspace 4";
            alt-shift-r = "move-node-to-workspace r";

            # 05-📼_Complex
            alt-5 = "workspace 5";
            alt-t = "workspace t";
            alt-shift-5 = "move-node-to-workspace 5";
            alt-shift-t = "move-node-to-workspace t";

            # 06-🌐_SysEng
            alt-6 = "workspace 6";
            alt-y = "workspace y";
            alt-shift-6 = "move-node-to-workspace 6";
            alt-shift-y = "move-node-to-workspace y";

            # 07-🤷🏻‍♀️_Uncert
            alt-7 = "workspace 7";
            alt-u = "workspace u";
            alt-shift-7 = "move-node-to-workspace 7";
            alt-shift-u = "move-node-to-workspace u";

            # 08-↗️_LinAlg
            alt-8 = "workspace 8";
            alt-i = "workspace i";
            alt-shift-8 = "move-node-to-workspace 8";
            alt-shift-i = "move-node-to-workspace i";

            # 09-🔄_Other
            alt-9 = "workspace 9";
            alt-o = "workspace o";
            alt-shift-9 = "move-node-to-workspace 9";
            alt-shift-o = "move-node-to-workspace o";

            # See: https://nikitabobko.github.io/AeroSpace/commands#workspace-back-and-forth
            alt-tab = "workspace-back-and-forth";
            # See: https://nikitabobko.github.io/AeroSpace/commands#move-workspace-to-monitor
            alt-shift-tab = "move-workspace-to-monitor --wrap-around next";

            # See: https://nikitabobko.github.io/AeroSpace/commands#mode
            alt-shift-semicolon = "mode service";
          };

          # 'service' binding mode declaration.
          # See: https://nikitabobko.github.io/AeroSpace/guide#binding-modes
          mode.service.binding = {
            esc = ["reload-config" "mode main"];
            r = ["flatten-workspace-tree" "mode main"]; # reset layout
            f = ["layout floating tiling" "mode main"]; # Toggle between floating and tiling layout
            backspace = ["close-all-windows-but-current" "mode main"];

            # sticky is not yet supported https://github.com/nikitabobko/AeroSpace/issues/2
            #s = ["layout sticky tiling" "mode main"];

            alt-shift-h = ["join-with left" "mode main"];
            alt-shift-j = ["join-with down" "mode main"];
            alt-shift-k = ["join-with up" "mode main"];
            alt-shift-l = ["join-with right" "mode main"];
          };
        };
      };

      # Launch Agents for startup programs
      # launchd.user.agents = {
      #   # Example: Auto-start a service
      #   # my-service = {
      #   #   command = "${pkgs.some-package}/bin/some-command";
      #   #   serviceConfig = {
      #   #     KeepAlive = true;
      #   #     RunAtLoad = true;
      #   #     StandardOutPath = "/tmp/my-service.out.log";
      #   #     StandardErrorPath = "/tmp/my-service.err.log";
      #   #   };
      #   # };
      # };

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
        zsh = {
          enable = true;
          # ohMyZsh = {
          #   enable = true;
          #   # plugins = [ "git" ];
          #   theme = "dracula";
          # };
        };
      };

      # Set Git commit hash for darwin-version
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # User running nix-darwin
      users.users.gat = {
        name = "gat";
        home = "/Users/gat";
      };
      system.primaryUser = "gat";
      
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
            profiles.default.extensions = with pkgs.vscode-marketplace; [
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

      # Might need to upgrade home-manager
      # programs.ghostty = {
      #   enable = true;
        # enableBashIntegration = true;
        # enableZshIntegration = true;
        # enableFishIntegration = true;
        # enableNushellIntegration = true;
        # enablePowerShellIntegration = true;
        # installVimSyntax = false;
      # };

      # oh-my-zsh is now configured via programs.zsh.ohMyZsh above

      # Used for backwards compatibility, please read the changelog before changing
      system.stateVersion = 5;

      # Font configuration - updated to use packages instead of fonts
      fonts.packages = [
        pkgs.monaspace
        # pkgs.fira-code
        # (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
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
          # Core tools that aren't in nixpkgs or work better via homebrew
          "tre-command"
          "clipboard"
          
          # Search & Navigation tools not in nixpkgs
          "ov" # from noborus/tap
          
          # System Monitoring tools not in nixpkgs
          "mayowa-ojo/tap/chmod-cli"
          
          # Network tools not in nixpkgs
          "sshs"
          "syncthing"
          "xxh"
          "zrok"
          "dns2tcp"
          "knock"
          "ucspi-tcp"
          
          # Development tools not in nixpkgs
          "rich"
          "yo"
          "biome"
          "flit"
          "pyright"
          "cruft"
          # "nat-n/poethepoet/poethepoet"
          "mdformat"
          "tex-fmt"
          "latexindent"
          "devcontainer"
          "hadolint"
          
          # Version control tools not in nixpkgs
          "git-filter-repo"
          "bfg"
          "commitizen"
          "czg"
          "check-jsonschema"
          "gitleaks"
          
          # Terminal tools not in nixpkgs
          "zellij"
          "charmbracelet/tap/freeze"
          "vhs"
          "huggingface-cli"
          # "oh-my-posh" # Using starship
          
          # Security tools not in nixpkgs
          "fcrackzip"
          # "zenmap" # Wrong cask
          
          # Archive tools
          "gnu-tar"
          
          # Additional development tools
          # "dotnet-sdk" # Wrong cask
        ];

        casks = [
          # Browsers
          "brave-browser" 
          # "cleanshot@4.7.6" # Doesn't work
          # "fantastical" # I don't remember what this is
          "firefox"
          "google-chrome"
          "tor-browser"
          
          # Video & Media
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
          # "cold-turkey-blocker" # Requires rosetta 2 to be installed error (but it's already installed)
          "zotero"
          "lastpass"
          "flux"
          "spotify"
          "applite" # For exploring brew apps
          "obsidian"
          "raycast"
          "bartender"
          
          # Communication
          "discord"
          "messenger"
          "whatsapp"
          "zoom"
          "signal"
          "slack"
          
          # Games
          "epic-games"
          "gog-galaxy"
          "steam"
          "minecraft"
          
          # Security & Development
          "metasploit"
          "burp-suite"
          "qflipper"
          
          # Programming & IDEs
          "visual-studio-code"
          "cursor"
          "postman"
          "git-credential-manager"
          "gitkraken"
          "claude"
          "netron"
          # "miniconda"
          # "sage"
          # "racket"
          # "dotnet-sdk"
          
          # Terminals
          "warp"
          "ghostty"
          "powershell"
          
          # System Tools
          # "kubernetes-cli" # Wrong cask
          
          # Fonts
          "font-fira-code"
          "font-fira-code-nerd-font"
          "font-blackout"
          "font-computer-modern"
          "font-noto-naskh-arabic"
          "font-noto-serif"
          "font-noto-serif-bengali"
          "font-noto-serif-cjk"
          "font-noto-serif-devanagari"
          "font-noto-serif-hebrew"
          "font-noto-serif-thai"
          "font-nova-round"
        ];

        # masApps = {
        #   "Drafts" = 1435957248;
        #   "Reeder" = 1529448980;
        #   "Things" = 904280696;
        #   "Timery" = 1425368544;
        # };
      };

      # System defaults
      # system.activationScripts.extraActivation.text = ''
      #   softwareupdate --install-rosetta --agree-to-license
      # '';
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
