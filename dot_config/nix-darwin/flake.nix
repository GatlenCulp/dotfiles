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
      secrets = import ./secrets.nix;

      # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ System Packages ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
      systemPackages = pkgs:
        with pkgs; [
          # Core Development Tools
          lunarvim
          nixfmt-classic
          nixpkgs-fmt

          # File Operations & Utilities
          brotli
          curl
          gnutar
          gnugrep
          xz

          # Network & Security Tools
          aircrack-ng
          john
          nmap
          openvpn
          socat
          sqlmap
          tcpflow
          tcpreplay
          wireshark

          # Development & Productivity
          act
          actionlint
          awscli
          chezmoi
          go-task
          shellcheck
          shfmt
          terraform
          tldr
          dvc-with-remotes
          # python312Packages.dvc
          # python312Packages.dvc-gdrive

          # Programming Languages & Runtimes
          cargo
          clippy
          cookiecutter
          go
          pylint
          python3
          ruby
          rustc
          # ruff

          # Document Processing & Databases
          pandoc
          sqlite
          taplo
          typst
          typstyle

          # Miscellaneous
          git-lfs
          neo-cowsay
          resvg
          poppler
          # tailscale
          # claude-code (out of date)
        ];

      # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Aerospace Configuration ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
      aerospaceConfig = {
        enable = true;
        settings = import ./aerospace-config.nix;
      };

      # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Homebrew Configuration ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
      homebrewConfig = {
        enable = true;
        taps = [ "charmbracelet/tap" "mayowa-ojo/tap" "noborus/tap" ];

        brews = [
          # CLI Tools
          "clipboard"
          "mayowa-ojo/tap/chmod-cli"
          "ov"
          "rich"
          "tre-command"

          # Network Tools
          "dns2tcp"
          "knock"
          "sshs"
          "syncthing"
          "ucspi-tcp"
          "xxh"
          "zrok"

          # Development Tools
          "biome"
          "cruft"
          "devcontainer"
          "flit"
          "hadolint"
          "mdformat"
          "pyright"
          "yo"

          # LaTeX & Document Processing
          "latexindent"
          "tex-fmt"

          # Git Tools
          "bfg"
          "check-jsonschema"
          "commitizen"
          "czg"
          "git-filter-repo"
          "gitleaks"

          # Creative Tools
          "charmbracelet/tap/freeze"
          "huggingface-cli"
          "vhs"

          # Security & Archive
          "fcrackzip"
          "gnu-tar"
        ];

        casks = [
          # Browsers
          "brave-browser"
          "google-chrome"
          "tor-browser"

          # Development & Productivity
          "claude"
          "claude-code"
          "cursor"
          "git-credential-manager"
          "gitkraken"
          "netron"
          "orbstack"
          "postman"

          # Communication
          "discord"
          "messenger"
          "signal"
          "slack"
          "whatsapp"
          "zoom"

          # Media & Creative
          "adobe-creative-cloud"
          "blender"
          "clipgrab"
          "loom"
          "obs"
          "vlc"
          "notunes"

          # Office & Organization
          "applite"
          "bartender"
          "cold-turkey-blocker"
          "dropbox"
          "flux"
          "freedom"
          "microsoft-auto-update"
          "microsoft-office"
          "notion"
          "notion-calendar"
          "raycast"
          "spotify"
          "zotero"

          # Gaming
          "epic-games"
          "gog-galaxy"
          "minecraft"
          "steam"

          # Security & Terminals
          "burp-suite"
          "ghostty"
          "metasploit"
          "powershell"
          "protonvpn"
          "qflipper"
          "warp"

          # Fonts
          "font-blackout"
          "font-computer-modern"
          "font-fira-code"
          "font-fira-code-nerd-font"
          "font-noto-naskh-arabic"
          "font-noto-serif"
          "font-noto-serif-bengali"
          "font-noto-serif-cjk"
          "font-noto-serif-devanagari"
          "font-noto-serif-hebrew"
          "font-noto-serif-thai"
          "font-nova-round"

          # Utilities
          "tailscale"
        ];
      };

      # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ System Defaults ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
      systemDefaults = {
        startup.chime = false;

        defaults = {
          dock = {
            expose-animation-duration = 5.0e-2;
            largesize = 32;
            minimize-to-application = true;
            orientation = "left";
            show-process-indicators = true;
            show-recents = false;
            tilesize = 24;
          };

          finder = {
            AppleShowAllExtensions = true;
            AppleShowAllFiles = true;
            CreateDesktop = false;
            FXEnableExtensionChangeWarning = false;
            FXPreferredViewStyle = "clmv";
            QuitMenuItem = true;
            ShowPathbar = true;
          };

          menuExtraClock = {
            Show24Hour = true;
            ShowDate = 0;
          };

          controlcenter = {
            BatteryShowPercentage = false;
            Bluetooth = false;
            Display = false;
            FocusModes = false;
            Sound = false;
          };

          NSGlobalDomain = {
            AppleICUForce24HourTime = true;
            AppleInterfaceStyle = "Dark";
            ApplePressAndHoldEnabled = false;
            AppleShowAllExtensions = true;
            AppleShowAllFiles = true;
            "com.apple.keyboard.fnState" = false;
          };
        };
      };

      # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Terminal Programs Configuration ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
      terminalPrograms = pkgs: {
        # Shell & Navigation
        atuin = {
          enable = true;
          settings = {
            inline_height = 18;
            max_preview_height = 1;
            theme.name = "dracula";
          };
          themes.dracula = {
            theme.name = "Dracula";
            colors = {
              AlertError = "#FF6E6E";
              AlertInfo = "#D6ACFF";
              AlertWarn = "#FFFFA5";
              Annotation = "#6272A4";
              Base = "#F8F8F2";
              Guidance = "#50FA7B";
              Important = "#A4FFFF";
              Title = "#ABB2BF";
            };
          };
        };

        bat = {
          enable = true;
          config.theme = "dracula";
          themes.dracula = {
            src = pkgs.fetchFromGitHub {
              owner = "dracula";
              repo = "sublime";
              rev = "26c57ec282abcaa76e57e055f38432bd827ac34e";
              sha256 = "019hfl4zbn4vm4154hh3bwk6hm7bdxbr1hdww83nabxwjn99ndhv";
            };
            file = "Dracula.tmTheme";
          };
        };

        eza = {
          enable = true;
          extraOptions = [ "--width=100" "--group-directories-first" "--all" ];
          git = true;
          icons = "auto";
          theme = "dracula";
        };
        jq.enable = true;
        fzf.enable = true;
        fd.enable = true;
        starship = {
          enable = true;
          settings = import ./starship-config.nix;
        };
        yazi.enable = true;
        zoxide.enable = true;

        # Development Tools
        git = {
          enable = true;
          delta.enable = true;
          extraConfig.init.defaultBranch = "main";
          ignores = [ ".DS_Store" ];
          lfs.enable = true;
          userEmail = "GatlenCulp@gmail.com";
          userName = "GatlenCulp";
        };

        gh = {
          enable = true;
          # gitCredentialHelper.enable = true;
          # hosts = {
          #   "github.com" = { user = "GatlenCulp"; };
          #   settings = { git_protocol = "ssh"; };
          # };
        };

        jujutsu = {
          enable = true;
          settings = {
            user = {
              email = "GatlenCulp@gmail.com";
              name = "Gatlen Culp";
            };
          };
        };

        # Programming Environment
        awscli.enable = true;
        bun.enable = true;
        mise.enable = true;
        nh.enable = true;
        nix-index.enable = true;
        poetry.enable = true;
        uv.enable = true;

        # Editors
        helix.enable = true;
        neovim = {
          # TODO: Configure this
          enable = true;
          viAlias = true;
          vimAlias = true;
        };
        zed-editor.enable = true;

        # System Monitoring & Utilities
        btop.enable = true;
        fastfetch = {
          enable = true;
          settings = import ./fastfetch-config.nix;
        };
        less.enable = true;
        thefuck.enable = true;
        topgrade.enable = true;

        # Terminal Multiplexers & Session Management
        zellij.enable = true;
        # sketchybar.enable = true;
        # obs-studio.enable = true;
        # obsidian.enable = true;
      };

      # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Shell Configuration ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
      shellConfig = 
        let
          sharedShellInit = ''
            export EDITOR=cursor
            export CSAIL_USERNAME=${secrets.csailUsername}
            # API Keys from secrets.nix
            export OPENAI_API_KEY="${secrets.apiKeys.openai}"
            export ANTHROPIC_API_KEY="${secrets.apiKeys.anthropic}"
            # export GITHUB_TOKEN="${secrets.apiKeys.github}"
            export AWS_DEFAULT_REGION="${secrets.aws.defaultRegion}"
            export AWS_PROFILE="${secrets.aws.profile}"
            fastfetch
          '';
        in {
        bash = {
          enable = true;
          enableCompletion = true;
          initExtra = sharedShellInit;
        };

        zsh = {
          enable = true;
          enableCompletion = true;
          initContent = sharedShellInit;
          prezto = {
            enable = true;
            python.virtualenvAutoSwitch = true;
            utility.safeOps = true;
          };
          syntaxHighlighting.enable = true;
        };

        nushell.enable = true;
        tmux.enable = true;
        vesktop.enable = true;
      };

      # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Application Programs ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
      applicationPrograms = pkgs: {
        # Media & Communication
        mpv.enable = true;
        thunderbird = {
          enable = true;
          profiles."Gatlen" = { isDefault = true; };
        };

        # Development & Productivity
        pandoc.enable = true;
        ruff = {
          enable = true;
          settings = { };
        };

        # Network & Security
        ssh = {
          enable = true;
          extraConfig = ''
            Include ~/.ssh/align.ssh
            Include ~/.ssh/metr.ssh
            Include ~/.ssh/extra.ssh
          '';
        };

        # Browsers (commented out)
        # chromium = {
        #   enable = true;
        # };
        # firefox = import ./firefox.nix { inherit pkgs; };
      };

      # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Home Manager Configuration ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
      homeManagerConfig = { pkgs, ... }: {
        home.stateVersion = "25.05";
        home.shellAliases.config = "$EDITOR ~/.config/nix-darwin";
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
                extensions = import ./vscode-extensions.nix { inherit pkgs; };
                userSettings = import ./vscode-settings.nix;
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
        fonts.packages = with pkgs; [
          fira-code
          fira-math
          julia-mono
          monaspace
          nerd-fonts.fira-code
          newcomputermodern
        ];

        # Services
        services.aerospace = aerospaceConfig;
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
