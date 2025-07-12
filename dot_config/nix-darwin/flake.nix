# Not yet installed: sudo nix run nix-darwin -- switch --flake ~/.config/nix-darwin
# Installed: sudo darwin-rebuild switch --flake ~/.config/nix-darwin
# 
# nix-darwin: https://nix-darwin.github.io/nix-darwin/manual/index.html
# home-manager: https://nix-community.github.io/home-manager/options.xhtml
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
          neo-cowsay
          nixpkgs-fmt
          nixfmt-classic

          # File Operations & Utilities
          xz
          gnutar
          gnugrep
          curl

          # Network & Security Tools
          wireshark
          tcpflow
          tcpreplay
          socat
          openvpn
          aircrack-ng
          nmap
          john
          sqlmap

          # Development & Productivity
          terraform
          tldr
          git-lfs
          shellcheck
          shfmt
          typst
          typstyle
          chezmoi
          go-task
          awscli
          act
          actionlint

          # Programming Languages & Runtimes
          rustc
          cargo
          clippy
          go
          ruby
          python3
          pylint
          ruff
          cookiecutter

          # Document Processing & Databases
          pandoc
          taplo
          sqlite
          brotli
          # tailscale
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
          "tre-command"
          "clipboard"
          "ov"
          "mayowa-ojo/tap/chmod-cli"

          # Network Tools
          "sshs"
          "syncthing"
          "xxh"
          "zrok"
          "dns2tcp"
          "knock"
          "ucspi-tcp"

          # Development Tools
          "rich"
          "yo"
          "biome"
          "flit"
          "pyright"
          "cruft"
          "mdformat"
          "tex-fmt"
          "latexindent"
          "devcontainer"
          "hadolint"

          # Git Tools
          "git-filter-repo"
          "bfg"
          "commitizen"
          "czg"
          "check-jsonschema"
          "gitleaks"

          # Creative Tools
          "charmbracelet/tap/freeze"
          "vhs"
          "huggingface-cli"

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
          "visual-studio-code"
          "cursor"
          "postman"
          "git-credential-manager"
          "gitkraken"
          "claude"
          "netron"
          "orbstack"
          "cold-turkey-blocker"

          # Communication
          "discord"
          "messenger"
          "whatsapp"
          "zoom"
          "signal"
          "slack"

          # Media & Creative
          "obs"
          "loom"
          "blender"
          "adobe-creative-cloud"
          "clipgrab"
          "vlc"

          # Office & Organization
          "microsoft-office"
          "microsoft-auto-update"
          "notion"
          "notion-calendar"
          "dropbox"
          "freedom"
          "zotero"
          "flux"
          "spotify"
          "applite"
          "obsidian"
          "raycast"
          "bartender"

          # Gaming
          "epic-games"
          "gog-galaxy"
          "steam"
          "minecraft"

          # Security & Terminals
          "metasploit"
          "burp-suite"
          "qflipper"
          "warp"
          "ghostty"
          "powershell"
          "protonvpn"

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

          "tailscale"
        ];
      };

      # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ System Defaults ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
      systemDefaults = {
        startup.chime = false;

        defaults = {
          dock = {
            orientation = "left";
            show-process-indicators = true;
            show-recents = false;
            expose-animation-duration = 5.0e-2;
            tilesize = 24;
            largesize = 32;
            minimize-to-application = true;
          };

          finder = {
            AppleShowAllExtensions = true;
            AppleShowAllFiles = true;
            CreateDesktop = false;
            ShowPathbar = true;
            FXEnableExtensionChangeWarning = false;
            FXPreferredViewStyle = "clmv";
            QuitMenuItem = true;
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
            AppleShowAllFiles = true;
            AppleShowAllExtensions = true;
            AppleInterfaceStyle = "Dark";
            ApplePressAndHoldEnabled = false;
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
            theme.name = "dracula";
            max_preview_height = 1;
          };
          themes.dracula = {
            theme.name = "Dracula";
            colors = {
              AlertInfo = "#D6ACFF";
              AlertWarn = "#FFFFA5";
              AlertError = "#FF6E6E";
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
          git = true;
          icons = "auto";
          theme = "dracula";
          extraOptions = [ "--width=100" "--group-directories-first" "--all" ];
        };

        starship = {
          enable = true;
          settings = import ./starship-config.nix;
        };

        # Development Tools
        git = {
          enable = true;
          userEmail = "GatlenCulp@gmail.com";
          userName = "GatlenCulp";
          delta.enable = true;
          ignores = [ ".DS_Store" ];
          lfs.enable = true;
          extraConfig.init.defaultBranch = "main";
        };

        # Misc Terminal Tools
        btop.enable = true;
        fastfetch.enable = true;
        thefuck.enable = true;
        less.enable = true;
        gh.enable = true;
        neovim = {
          enable = true;
          viAlias = true;
          vimAlias = true;
        };
        topgrade.enable = true;
        uv.enable = true;
        poetry.enable = true;
        mise.enable = true;
        yazi.enable = true;
        nh.enable = true;
        fzf.enable = true;
        helix.enable = true;
        awscli.enable = true;
        bun.enable = true;
        zed-editor.enable = true;
      };

      # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Shell Configuration ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
      shellConfig = {
        bash = {
          enable = true;
          enableCompletion = true;
          initExtra = ''
            export EDITOR=cursor
            export CSAIL_USERNAME=${secrets.csailUsername}
            # API Keys from secrets.nix
            export OPENAI_API_KEY="${secrets.apiKeys.openai}"
            export ANTHROPIC_API_KEY="${secrets.apiKeys.anthropic}"
            export GITHUB_TOKEN="${secrets.apiKeys.github}"
            export AWS_DEFAULT_REGION="${secrets.aws.defaultRegion}"
            export AWS_PROFILE="${secrets.aws.profile}"
          '';
        };

        zsh = {
          enable = true;
          prezto = {
            enable = true;
            python.virtualenvAutoSwitch = true;
            utility.safeOps = true;
          };
          enableCompletion = true;
          syntaxHighlighting.enable = true;
          initContent = ''
            export EDITOR=cursor
            export CSAIL_USERNAME=${secrets.csailUsername}
            # API Keys from secrets.nix
            export OPENAI_API_KEY="${secrets.apiKeys.openai}"
            export ANTHROPIC_API_KEY="${secrets.apiKeys.anthropic}"
            export GITHUB_TOKEN="${secrets.apiKeys.github}"
            export AWS_DEFAULT_REGION="${secrets.aws.defaultRegion}"
            export AWS_PROFILE="${secrets.aws.profile}"
          '';
        };

        nushell.enable = true;
      };

      # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Application Programs ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
      applicationPrograms = pkgs: {
        firefox = import ./firefox.nix { inherit pkgs; };
        mpv.enable = true;
        thunderbird = {
          enable = true;
          profiles."Gatlen".isDefault = true;
        };
        pandoc.enable = true;
        ruff = {
          enable = true;
          settings = { };
        };
        ssh = {
          enable = true;
          extraConfig = ''
            Include ~/.ssh/align.ssh
            Include ~/.ssh/metr.ssh
            Include ~/.ssh/extra.ssh
          '';
        };
        zoxide.enable = true;
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
          dataHome = "/Users/gat/.local/share";
          configHome = "/Users/gat/.config";
          cacheHome = "/Users/gat/.cache";
        };

        programs = terminalPrograms pkgs // shellConfig
          // applicationPrograms pkgs // {
            vscode = {
              enable = true;
              profiles.default = {
                userSettings = import ./vscode-settings.nix;
                extensions = import ./vscode-extensions.nix { inherit pkgs; };
              };
            };
          };
      };

      # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Main Darwin Configuration ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
      configuration = { pkgs, ... }: {
        # Core Setup
        imports = [ home-manager.darwinModules.home-manager ];
        nixpkgs.overlays =
          [ nix-vscode-extensions.overlays.default nur.overlays.default ];
        nixpkgs.hostPlatform = "aarch64-darwin";
        nixpkgs.config.allowUnfree = true;

        # Environment
        environment = {
          pathsToLink = [ "/share/zsh" "/share/bash-completion" ];
          systemPath =
            [ "/Users/gat/.cargo/bin" "/Users/gat/.local/share/../bin" ];
          systemPackages = systemPackages pkgs;
          darwinConfig = "$HOME/.config/nix-darwin";
        };

        # Services
        services.aerospace = aerospaceConfig;
        programs.gnupg.agent.enable = true;

        # Nix Configuration
        nix = {
          # Handled by Determinate Nix
          enable = false;
          package = pkgs.nix;
          settings."extra-experimental-features" = [ "nix-command" "flakes" ];
        };

        # System Configuration
        system = systemDefaults // {
          configurationRevision = self.rev or self.dirtyRev or null;
          stateVersion = 5;
          primaryUser = "gat";
        };

        # User Configuration
        users.users.gat = {
          name = "gat";
          home = "/Users/gat";
        };

        # Fonts
        fonts.packages = with pkgs; [
          monaspace
          julia-mono
          newcomputermodern
          fira-code
          nerd-fonts.fira-code
          fira-math
        ];

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
