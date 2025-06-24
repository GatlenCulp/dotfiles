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
  };

  outputs =
    inputs@{ self, nix-darwin, nixpkgs, home-manager, nix-vscode-extensions }:
    let
      configuration = { pkgs, ... }: {
        # Import home-manager module
        imports = [ home-manager.darwinModules.home-manager ];

        # Add the overlay for VSCode extensions
        nixpkgs.overlays = [ nix-vscode-extensions.overlays.default ];

        environment.pathsToLink = [ "/share/zsh" "/share/bash-completion" ];
        environment.systemPath =
          [ "/Users/gat/.cargo/bin" "/Users/gat/.local/share/../bin" ];

        environment.systemPackages = [
          # Core tools
          pkgs.lunarvim
          pkgs.neo-cowsay

          pkgs.nixpkgs-fmt
          pkgs.nixfmt-classic
          # pkgs.pre-commit # Takes too long to build

          # File operations
          pkgs.xz
          pkgs.gnutar

          # Search & Navigation
          pkgs.gnugrep

          # Network tools
          pkgs.curl
          pkgs.wireshark
          pkgs.tcpflow
          pkgs.tcpreplay
          pkgs.socat
          pkgs.openvpn
          # pkgs.tcptrace

          # Development tools
          pkgs.tldr

          # Version control
          pkgs.git-lfs

          # # Shell utilities
          pkgs.shellcheck
          pkgs.shfmt

          # Typst
          pkgs.typst
          pkgs.typstyle

          # # Configuration
          pkgs.chezmoi

          # # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Programming Languages ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #

          # Rust
          pkgs.rustc
          pkgs.cargo
          pkgs.clippy

          # Go
          pkgs.go

          # Web Development
          # pkgs.nodejs
          # pkgs.typescript

          # Scripting Languages
          # pkgs.php
          pkgs.ruby
          # pkgs.perl
          # pkgs.lua
          # pkgs.luajit

          # # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Python Development ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #

          # Package Management & Tools
          pkgs.python3

          # Quality Assurance
          pkgs.pylint
          pkgs.ruff

          # Project Tools
          pkgs.cookiecutter

          # # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Document & Text Processing ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #

          # Markdown & Documentation
          pkgs.pandoc

          # Configuration Formats
          pkgs.taplo # TOML toolkit

          # Code Formatting
          # pkgs.prettier
          # pkgs.tidy-html5

          # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Databases ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #

          # pkgs.postgresql_16
          pkgs.sqlite

          # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Container & DevOps ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #

          # # pkgs.kubectl

          # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Development Tools ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #

          # pkgs.jupyterlab

          # Task Runners & Build Tools
          pkgs.go-task

          # API & Testing
          pkgs.awscli

          # GitHub Actions
          pkgs.act
          pkgs.actionlint

          # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Security & Penetration Testing ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #

          # Network Security
          pkgs.aircrack-ng
          pkgs.nmap

          # Password Tools
          # pkgs.hydra
          pkgs.john

          # SQL Security
          pkgs.sqlmap

          # # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ System Utilities ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #

          # Archive & Compression
          pkgs.brotli

          pkgs.tailscale
        ];

        # Use a custom configuration.nix location
        environment.darwinConfig = "$HOME/.config/nix-darwin";

        # Auto upgrade nix package and the daemon service
        # services.nix-daemon.enable = false;

        # Apparently this doesn't exist??
        # services.home-manager.autoUpgrade.enable = true;

        # Aerospace window manager configuration
        services.aerospace = {
          enable = true;
          settings = {
            after-login-command = [ ];
            after-startup-command = [ ];
            enable-normalization-flatten-containers = true;
            enable-normalization-opposite-orientation-for-nested-containers =
              true;
            accordion-padding = 50;
            default-root-container-layout = "tiles";
            default-root-container-orientation = "auto";
            on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];
            automatically-unhide-macos-hidden-apps = true;
            key-mapping = { preset = "qwerty"; };
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
            mode.main.binding = {
              alt-enter = ''
                exec-and-forget osascript -e '
                tell application "Ghostty"
                    do script
                    activate
                end tell'
              '';

              alt-slash = "layout tiles horizontal vertical";
              alt-comma = "layout accordion horizontal vertical";

              alt-h = "focus left";
              alt-j = "focus down";
              alt-k = "focus up";
              alt-l = "focus right";

              alt-shift-h = "move left";
              alt-shift-j = "move down";
              alt-shift-k = "move up";
              alt-shift-l = "move right";

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

              alt-tab = "workspace-back-and-forth";
              alt-shift-tab = "move-workspace-to-monitor --wrap-around next";
              alt-shift-semicolon = "mode service";
            };
            mode.service.binding = {
              esc = [ "reload-config" "mode main" ];
              r = [ "flatten-workspace-tree" "mode main" ]; # reset layout
              f = [
                "layout floating tiling"
                "mode main"
              ]; # Toggle between floating and tiling layout
              backspace = [ "close-all-windows-but-current" "mode main" ];

              alt-shift-h = [ "join-with left" "mode main" ];
              alt-shift-j = [ "join-with down" "mode main" ];
              alt-shift-k = [ "join-with up" "mode main" ];
              alt-shift-l = [ "join-with right" "mode main" ];
            };
          };
        };

        # TODO
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
            "extra-experimental-features" = [ "nix-command" "flakes" ];
          };
        };

        programs.gnupg.agent.enable = true;

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
          backupFileExtension = "backup";
          useGlobalPkgs = true;
          useUserPackages = true;
          users.gat = { pkgs, ... }: {
            home.stateVersion = "25.05";
            home.shellAliases = { config = "$EDITOR ~/.config/nix-darwin"; };
            home.shell.enableShellIntegration = true;
            home.shell.enableZshIntegration = true;

            ### Computer Setup ###
            xdg = {
              enable = true;
              dataHome = "/Users/gat/.local/share";
              configHome = "/Users/gat/.config";
              cacheHome = "/Users/gat/.cache";
            };

            # Marked as broken?
            # programs.ghostty = {
            #   enable = true;
            #   # enableBashIntegration = true;
            #   # enableZshIntegration = true;
            #   # enableFishIntegration = true;
            #   # enableNushellIntegration = true;
            #   # enablePowerShellIntegration = true;
            #   # installVimSyntax = false;
            # };

            # programs.chromium.enable = true; # Gets error
            programs.firefox.enable = true;
            programs.mpv.enable = true;
            programs.thunderbird = {
              enable = true;
              profiles."Gatlen" = { isDefault = true; };
            };
            # programs.obs-studio.enable = true; # Not available on arm
            # programs.obsidian.enable = true; # Fails?
            programs.pandoc.enable = true;
            programs.ruff = {
              enable = true;
              settings = { };
            };
            # programs.sesh.enable = true;
            programs.ssh.enable = true;
            programs.zoxide.enable = true;

            ### Terminal Shtuff ###
            programs.atuin = {
              enable = true;
              settings = {
                inline_height = 18;
                theme.name = "dracula";
                max_preview_height = 1;
              };
              themes = {
                dracula = {
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
            };
            programs.bat = {
              enable = true;
              config.theme = "dracula";
              themes.dracula = {
                src = pkgs.fetchFromGitHub {
                  owner = "dracula";
                  repo = "sublime"; # Bat uses sublime syntax for its themes
                  rev = "26c57ec282abcaa76e57e055f38432bd827ac34e";
                  sha256 =
                    "019hfl4zbn4vm4154hh3bwk6hm7bdxbr1hdww83nabxwjn99ndhv";
                };
                file = "Dracula.tmTheme";
              };
            };
            programs.awscli.enable = true;
            programs.btop.enable = true;
            programs.eza = {
              enable = true;
              git = true;
              icons = "auto";
              theme = "dracula";
              extraOptions = [
                # General Options
                "--width=100"
                # "--hyperlink" A bit distracting
                "--group-directories-first"
                "--all"
                # 
              ];
            };
            programs.fastfetch = {
              enable = true;
              # This doesn't work? :(
              settings = {
                logo = {
                  source = "nixos_small";
                  padding = { right = 1; };
                };
                display = {
                  size = { binaryPrefix = "si"; };
                  color = "blue";
                  separator = "  ";
                };
                modules = [
                  {
                    type = "datetime";
                    key = "Date";
                    format = "{1}-{3}-{11}";
                  }
                  {
                    type = "datetime";
                    key = "Time";
                    format = "{14}:{17}:{20}";
                  }
                  "break"
                  "player"
                  "media"
                ];
              };
            };
            programs.thefuck.enable = true;
            programs.less.enable = true;
            programs.gh.enable = true;
            programs.git = {
              enable = true;
              userEmail = "GatlenCulp@gmail.com";
              userName = "GatlenCulp";
              delta = {
                enable = true;
                options = { };
              };
              ignores = [ ".DS_Store" ];
              lfs.enable = true;
              extraConfig = { init.defaultBranch = "main"; };

            };
            programs.neovim = {
              enable = true;
              viAlias = true;
              vimAlias = true;
            };
            programs.topgrade.enable = true;
            programs.uv.enable = true;
            # programs.direnv.enable = true; # Not recommended to use with mise
            programs.mise.enable = true;
            programs.starship = {
              enable = true;
              settings = {
                format =
                  "[╭](fg:current_line)$os$directory$git_branch$git_status$fill$nodejs$bun$deno$aws$cmd_duration$shell$time$username$line_break$character";

                palette = "dracula";
                add_newline = true;

                palettes = {
                  dracula = {
                    foreground = "#F8F8F2";
                    background = "#282A36";
                    current_line = "#44475A";
                    primary = "#1E1F29";
                    box = "#44475A";
                    blue = "#6272A4";
                    cyan = "#8BE9FD";
                    green = "#50FA7B";
                    orange = "#FFB86C";
                    pink = "#FF79C6";
                    purple = "#BD93F9";
                    red = "#FF5555";
                    yellow = "#F1FA8C";
                  };
                };

                os = {
                  format =
                    "(fg:current_line)[](fg:red)[$symbol ](fg:primary bg:red)[](fg:red)";
                  disabled = false;
                  symbols = {
                    Alpine = "";
                    Amazon = "";
                    Android = "";
                    Arch = "";
                    CentOS = "";
                    Debian = "";
                    EndeavourOS = "";
                    Fedora = "";
                    FreeBSD = "";
                    Garuda = "";
                    Gentoo = "";
                    Linux = "";
                    Macos = "";
                    Manjaro = "";
                    Mariner = "";
                    Mint = "";
                    NetBSD = "";
                    NixOS = "";
                    OpenBSD = "";
                    OpenCloudOS = "";
                    openEuler = "";
                    openSUSE = "";
                    OracleLinux = "⊂⊃";
                    Pop = "";
                    Raspbian = "";
                    Redhat = "";
                    RedHatEnterprise = "";
                    Solus = "";
                    SUSE = "";
                    Ubuntu = "";
                    Unknown = "";
                    Windows = "";
                  };
                };

                directory = {
                  format =
                    "[─](fg:current_line)[](fg:pink)[󰷏 ](fg:primary bg:pink)[](fg:pink bg:box)[ $read_only$truncation_symbol$path](fg:foreground bg:box)[](fg:box)";
                  home_symbol = " ~/";
                  truncation_symbol = " ";
                  truncation_length = 2;
                  read_only = "󱧵 ";
                  read_only_style = "";
                };

                git_branch = {
                  format =
                    "[─](fg:current_line)[](fg:green)[$symbol](fg:primary bg:green)[](fg:green bg:box)[ $branch](fg:foreground bg:box)";
                  symbol = " ";
                };

                git_status = {
                  format = "[( $all_status)](fg:foreground bg:box)[](fg:box)";
                };

                nodejs = {
                  format =
                    "[─](fg:current_line)[](fg:green)[$symbol](fg:primary bg:green)[](fg:green bg:box)[ $version](fg:foreground bg:box)[](fg:box)";
                  detect_files = [
                    "package.json"
                    ".node-version"
                    "!bunfig.toml"
                    "!bun.lockb"
                  ];
                };

                bun = {
                  format =
                    "[─](fg:current_line)[](fg:green)[$symbol](fg:primary bg:green)[](fg:green bg:box)[ $version](fg:foreground bg:box)[](fg:box)";
                  symbol = "🥟";
                };

                deno = {
                  format =
                    "[─](fg:current_line)[](fg:green)[$symbol](fg:primary bg:green)[](fg:green bg:box)[ $version](fg:foreground bg:box)[](fg:box)";
                  symbol = "🦕";
                };

                aws = {
                  format =
                    "[─](fg:current_line)[](fg:purple)[$symbol](fg:primary bg:purple)[](fg:purple bg:box)[ $profile](fg:foreground bg:box)[](fg:box)";
                  symbol = "☁️";
                };

                fill = {
                  symbol = "─";
                  style = "fg:current_line";
                };

                cmd_duration = {
                  min_time = 500;
                  format =
                    "[─](fg:current_line)[](fg:orange)[ ](fg:primary bg:orange)[](fg:orange bg:box)[ $duration ](fg:foreground bg:box)[](fg:box)";
                };

                shell = {
                  format =
                    "[─](fg:current_line)[](fg:blue)[ ](fg:primary bg:blue)[](fg:blue bg:box)[ $indicator](fg:foreground bg:box)[](fg:box)";
                  disabled = false;
                };

                time = {
                  format =
                    "[─](fg:current_line)[](fg:purple)[󰦖 ](fg:primary bg:purple)[](fg:purple bg:box)[ $time](fg:foreground bg:box)[](fg:box)";
                  time_format = "%H:%M";
                  disabled = false;
                };

                username = {
                  format =
                    "[─](fg:current_line)[](fg:yellow)[ ](fg:primary bg:yellow)[](fg:yellow bg:box)[ $user](fg:foreground bg:box)[](fg:box) ";
                  show_always = true;
                };

                character = {
                  format = ''
                    [│](fg:current_line)
                    [╰─$symbol](fg:current_line) '';
                  success_symbol = "[](fg:bold green)";
                  error_symbol = "[](fg:bold red)";
                };
              };
            };

            programs.yazi.enable = true;
            # programs.tmux.enable = true;
            programs.zellij = {
              enable = false;
              enableBashIntegration = true;
              enableZshIntegration = true;
              settings.theme = "dracula";
            };
            programs.nh.enable = true;
            programs.fzf.enable = true;
            programs.helix.enable = true;

            ### Shell Stuff ###
            programs.bash = {
              enable = true;
              enableCompletion = true;
            };
            programs.ssh.extraConfig = ''
              Include ~/.ssh/align.ssh
              Include ~/.ssh/metr.ssh
              Include ~/.ssh/extra.ssh
            '';
            programs.nushell = { enable = true; };
            programs.zsh = {
              enable = true;
              # Kind of a pre-configured oh-my-zsh, enables all fun stuff by default.
              prezto.enable = true;
              enableCompletion = true;
              syntaxHighlighting.enable = true;
            };

            ### Lang Specific ###
            programs.bun.enable = true;

            ### Editor configuration ###
            programs.zed-editor.enable = true;
            programs.vscode = {
              enable = true;

              profiles.default.userSettings = {
                "workbench.colorTheme" = "Dracula Theme";
                "C_Cpp.updateChannel" = "Insiders";

                # Language-specific formatting settings
                "[css]" = {
                  "editor.defaultFormatter" = "esbenp.prettier-vscode";
                };
                "[eval-log]" = { };
                "[html]" = {
                  "editor.defaultFormatter" = "esbenp.prettier-vscode";
                };
                "[javascript]" = {
                  "editor.defaultFormatter" = "biomejs.biome";
                };
                "[json]" = {
                  "editor.defaultFormatter" = "esbenp.prettier-vscode";
                  "editor.tabSize" = 2;
                  "editor.wordWrap" = "on";
                };
                "[jsonc]" = {
                  "editor.defaultFormatter" = "vscode.json-language-features";
                };
                "[latex]" = {
                  "editor.defaultFormatter" = "James-Yu.latex-workshop";
                  "editor.wordWrap" = "on";
                  "editor.tabSize" = 2;
                  "editor.insertSpaces" = true;
                };
                "[tex]" = {
                  "editor.tabSize" = 2;
                  "editor.insertSpaces" = true;
                  "editor.wordWrap" = "on";
                };
                "[markdown]" = {
                  "editor.defaultFormatter" = "esbenp.prettier-vscode";
                  "editor.snippetSuggestions" = "inline";
                  "editor.suggest.showSnippets" = true;
                };
                "[nix]" = {
                  "editor.defaultFormatter" = "jnoortheen.nix-ide";
                  "editor.insertSpaces" = true;
                  "editor.tabSize" = 2;
                };
                "[python]" = {
                  "editor.codeActionsOnSave" = {
                    # "source.fixAll" = "explicit";
                    # "source.organizeImports" = "explicit";
                  };
                  "editor.defaultFormatter" = "charliermarsh.ruff";
                };
                "[racket]" = {
                  "editor.defaultFormatter" = "evzen-wybitul.magic-racket";
                };
                "[ruby]" = {
                  "editor.defaultFormatter" = "Shopify.ruby-lsp";
                  "editor.formatOnSave" = true;
                  "editor.formatOnType" = true;
                  "editor.insertSpaces" = true;
                  "editor.semanticHighlighting.enabled" = true;
                  "editor.tabSize" = 2;
                  "editor.wordSeparators" = ''`~@#$%^&*()-=+[{]}\|;:'",.<>/'';
                };
                "[shellscript]" = {
                  "editor.defaultFormatter" = "mads-hartmann.bash-ide-vscode";
                };
                "[svelte]" = {
                  "editor.defaultFormatter" = "svelte.svelte-vscode";
                };
                "[typescript]" = {
                  "editor.defaultFormatter" = "esbenp.prettier-vscode";
                };
                "[yaml]" = {
                  "editor.defaultFormatter" = "redhat.vscode-yaml";
                };
                "[typst]" = {
                  "editor.wordSeparators" = ''`~!@#$%^&*()=+[{]}\|;:'",.<>/?'';
                  "editor.formatOnSave" = true;
                };
                "[typst-code]" = {
                  "editor.wordSeparators" = ''`~!@#$%^&*()=+[{]}\|;:'",.<>/?'';
                };
                "[pddl]" = { "editor.defaultFormatter" = "jan-dolejsi.pddl"; };

                # Extension-specific settings
                "autoDocstring.docstringFormat" = "google-notypes";
                "autoDocstring.startOnNewLine" = true;

                # Better Comments configuration
                "better-comments.highlightPlainText" = false;
                "better-comments.tags" = [
                  {
                    "bold" = true;
                    "color" = "#282A36";
                    "italic" = true;
                    "tag" = "background";
                  }
                  {
                    "bold" = true;
                    "color" = "#F8F8F2";
                    "italic" = true;
                    "tag" = "foreground";
                  }
                  {
                    "bold" = true;
                    "color" = "#44475A";
                    "italic" = true;
                    "tag" = "selection";
                  }
                  {
                    "bold" = true;
                    "color" = "#6272A4";
                    "italic" = true;
                    "tag" = "comment";
                  }
                  {
                    "bold" = true;
                    "color" = "#FF5555";
                    "italic" = true;
                    "tag" = "red";
                  }
                  {
                    "bold" = true;
                    "color" = "#FFB86C";
                    "italic" = true;
                    "tag" = "orange";
                  }
                  {
                    "bold" = true;
                    "color" = "#F1FA8C";
                    "italic" = true;
                    "tag" = "yellow";
                  }
                  {
                    "bold" = true;
                    "color" = "#50FA7B";
                    "italic" = true;
                    "tag" = "green";
                  }
                  {
                    "bold" = true;
                    "color" = "#BD93F9";
                    "italic" = true;
                    "tag" = "purple";
                  }
                  {
                    "bold" = true;
                    "color" = "#8BE9FD";
                    "italic" = true;
                    "tag" = "cyan";
                  }
                  {
                    "bold" = true;
                    "color" = "#FF79C6";
                    "italic" = true;
                    "tag" = "pink";
                  }
                  {
                    "bold" = true;
                    "color" = "#50FA7B";
                    "italic" = true;
                    "tag" = "%%";
                  }
                  {
                    "bold" = true;
                    "color" = "#FF5555";
                    "italic" = true;
                    "tag" = "!!";
                  }
                  {
                    "bold" = true;
                    "color" = "#FF5555";
                    "italic" = true;
                    "tag" = "warning";
                  }
                  {
                    "bold" = true;
                    "color" = "#FF79C6";
                    "italic" = true;
                    "tag" = "??";
                  }
                  {
                    "bold" = true;
                    "color" = "#FF79C6";
                    "italic" = true;
                    "tag" = "question";
                  }
                  {
                    "bold" = true;
                    "color" = "#8BE9FD";
                    "italic" = true;
                    "tag" = "info";
                  }
                  {
                    "color" = "#6272A4";
                    "italic" = true;
                    "strikethrough" = true;
                    "tag" = "//";
                  }
                  {
                    "bold" = true;
                    "color" = "#FFB86C";
                    "italic" = true;
                    "tag" = "fixme";
                  }
                  {
                    "bold" = true;
                    "color" = "#F8F8F2";
                    "italic" = true;
                    "tag" = "━";
                  }
                  {
                    "bold" = true;
                    "color" = "#F8F8F2";
                    "italic" = true;
                    "tag" = "─";
                  }
                  {
                    "color" = "#F8F8F2";
                    "italic" = true;
                    "tag" = "##";
                    "underline" = true;
                  }
                ];

                # Comment divider settings
                "comment-divider.languagesMap" = { "toml" = [ "#" "#" ]; };
                "comment-divider.length" = 70;
                "comment-divider.lineFiller" = "─";
                "comment-divider.mainHeaderFiller" = "━";
                "comment-divider.mainHeaderHeight" = "line";
                "comment-divider.shouldLengthIncludeIndent" = true;
                "comment-divider.subheaderFiller" = "─";

                # Cursor-specific settings
                "cursor.aipreview.enabled" = true;
                "cursor.chat.showSuggestedFiles" = true;
                "cursor.chat.smoothStreaming" = true;
                "cursor.cmdk.useThemedDiffBackground" = true;
                "cursor.composer.renderPillsInsteadOfBlocks" = true;
                "cursor.composer.collapsePaneInputBoxPills" = true;
                "cursor.composer.shouldAllowCustomModes" = true;
                "cursor.composer.shouldChimeAfterChatFinishes" = true;
                "cursor.cpp.disabledLanguages" = [ "plaintext" "scminput" ];
                "cursor.cpp.enablePartialAccepts" = true;
                "cursor.general.enableShadowWorkspace" = true;

                # Debug settings
                "debug.console.fontFamily" = "FiraCode Nerd Font";
                "debug.console.fontSize" = 10;
                "debug.hideLauncherWhileDebugging" = true;
                "debug.internalConsoleOptions" = "openOnSessionStart";
                "debug.showSubSessionsInToolBar" = true;
                "debug.showVariableTypes" = true;

                # Diff editor settings
                "diffEditor.wordWrap" = "off";

                # Dotenv settings
                "dotenv.enableAutocloaking" = true;

                # Editor settings
                "editor.acceptSuggestionOnEnter" = "off";
                "editor.accessibilityPageSize" = 11;
                "editor.codeLensFontFamily" = "FiraCode Nerd Font";
                "editor.cursorSmoothCaretAnimation" = "on";
                "editor.fontFamily" = "FiraCode Nerd Font";
                "editor.fontLigatures" = true;
                "editor.formatOnType" = true;
                "editor.gotoLocation.multipleDefinitions" = "gotoAndPeek";
                "editor.gotoLocation.multipleImplementations" = "gotoAndPeek";
                "editor.gotoLocation.multipleReferences" = "gotoAndPeek";
                "editor.gotoLocation.multipleTypeDefinitions" = "gotoAndPeek";
                "editor.guides.bracketPairs" = false;
                "editor.inlayHints.enabled" = "off";
                "editor.inlayHints.fontFamily" = "FiraCode Nerd Font";
                "editor.inlineSuggest.enabled" = true;
                "editor.largeFileOptimizations" = false;
                "editor.minimap.autohide" = true;
                "editor.minimap.enabled" = false;
                "editor.minimap.renderCharacters" = false;
                "editor.minimap.side" = "left";
                "editor.peekWidgetDefaultFocus" = "editor";
                "editor.unicodeHighlight.ambiguousCharacters" = false;
                "editor.wordWrap" = "bounded";
                "editor.wordWrapColumn" = 100;

                # Token color customizations
                "editor.tokenColorCustomizations" = {
                  "[*Dark*]" = {
                    "textMateRules" = [{
                      "scope" = "ref.matchtext";
                      "settings" = { "foreground" = "#fff"; };
                    }];
                  };
                  "[*Light*]" = {
                    "textMateRules" = [{
                      "scope" = "ref.matchtext";
                      "settings" = { "foreground" = "#000"; };
                    }];
                  };
                  "textMateRules" = [ ];
                };

                # Error lens settings
                "errorLens.codeLensEnabled" = false;
                "errorLens.codeLensOnClick" = "showProblemsView";
                "errorLens.followCursor" = "allLinesExceptActive";
                "errorLens.fontFamily" = "FiraCode Nerd Font";
                "errorLens.messageEnabled" = true;

                # Files settings
                "files.associations" = {
                  "**/.x-cmd/*.yml" = "yaml";
                  "*.css" = "css";
                  "*.cursorrules" = "markdown";
                  "*.env*" = "dotenv";
                  "*.eval" = "eval-log";
                  "*.spec" = "python";
                  "*.ssh" = "ssh_config";
                  "*.toml.tmpl" = "toml";
                  "*Brewfile*" = "ruby";
                  ".czrc" = "json";
                  ".env*" = "dotenv";
                  ".xonshrc" = "xonsh";
                  "_headers" = "properties";
                  "**/.x-cmd/*" = "shellscript";
                  "_redirects" = "properties";
                  ".aliases" = "shellscript";
                  ".bashrc" = "shellscript";
                  ".exports" = "shellscript";
                  ".functions" = "shellscript";
                  "*.sh.tmpl" = "shellscript";
                  ".shrc" = "shellscript";
                  ".zshrc" = "shellscript";
                  "dot_*" = "shellscript";
                  "sh.tmpl" = "shellscript";
                  ".envrc" = "shellscript";
                };
                "files.autoSave" = "afterDelay";
                "files.exclude" = {
                  "**/.DS_Store" = true;
                  "**/.git" = true;
                  "**/.hg" = true;
                  "**/.ruby-lsp" = true;
                  "**/.svn" = true;
                  "**/CVS" = true;
                  "**/Thumbs.db" = true;
                  "**/.trunk/*actions/" = true;
                  "**/.trunk/*logs/" = true;
                  "**/.trunk/*notifications/" = true;
                  "**/.trunk/*out/" = true;
                  "**/.trunk/*plugins/" = true;
                };
                "files.watcherExclude" = {
                  "**/.trunk/*actions/" = true;
                  "**/.trunk/*logs/" = true;
                  "**/.trunk/*notifications/" = true;
                  "**/.trunk/*out/" = true;
                  "**/.trunk/*plugins/" = true;
                };

                # Fold settings
                "fold.level" = 1;

                # Git settings
                "git.autofetch" = true;
                "git.openRepositoryInParentFolders" = "never";

                # GitHub Copilot settings
                "github.copilot.editor.enableAutoCompletions" = true;
                "github.copilot.enable" = {
                  "*" = true;
                  "markdown" = false;
                  "plaintext" = false;
                };

                # GitHub settings
                "githubLocalActions.dockerDesktopPath" =
                  "/Applications/Docker.app";
                "githubPullRequests.pullBranch" = "never";

                # GitLens settings
                "gitlens.ai.experimental.model" =
                  "anthropic:claude-3-5-sonnet-20240620";
                "gitlens.ai.experimental.openai.model" = "gpt-4o";
                "gitlens.ai.experimental.provider" = "openai";
                "gitlens.blame.fontFamily" = "FiraCode Nerd Font";
                "gitlens.currentLine.fontFamily" = "FiraCode Nerd Font";
                "gitlens.graph.dateFormat" = null;
                "gitlens.graph.dimMergeCommits" = true;
                "gitlens.graph.minimap.additionalTypes" = [ "stashes" ];
                "gitlens.graph.minimap.enabled" = false;
                "gitlens.heatmap.locations" = [ "gutter" "overview" ];
                "gitlens.statusBar.enabled" = false;
                "gitlens.views.commitDetails.files.layout" = "list";

                # Interactive window settings
                "interactiveWindow.executeWithShiftEnter" = true;

                # JavaScript settings
                "javascript.updateImportsOnFileMove.enabled" = "always";

                # Julia settings
                "julia.enableTelemetry" = true;
                "julia.symbolCacheDownload" = true;

                # Jupyter settings
                "jupyter.askForKernelRestart" = false;
                "jupyter.interactiveWindow.creationMode" = "perFile";
                "jupyter.interactiveWindow.textEditor.autoAddNewCell" = false;
                "jupyter.kernels.trusted" =
                  [ "/Users/gat/work/FA2024/DL/secrets/kernel.json" ];
                "jupyter.themeMatplotlibPlots" = true;

                # LaTeX Workshop settings
                "latex-workshop.bibtex-format.sort.enabled" = true;
                "latex-workshop.formatting.latex" = "tex-fmt";
                "latex-workshop.intellisense.subsuperscript.enabled" = true;
                "latex-workshop.showContextMenu" = true;
                "latex-workshop.synctex.indicator" = "circle";
                "latex-workshop.view.autoFocus.enabled" = true;
                "latex-workshop.view.outline.sync.viewer" = true;
                "latex-workshop.view.pdf.color.dark.backgroundColor" =
                  "#333333";

                # Live Preview settings
                "livePreview.customExternalBrowser" = "Chrome";
                "livePreview.debugOnExternalPreview" = true;
                "livePreview.defaultPreviewPath" = "https://localhost:4000";
                "livePreview.httpHeaders" = { "Accept-Ranges" = "bytes"; };
                "livePreview.openPreviewTarget" = "External Browser";
                "livePreview.portNumber" = 4000;

                # Makefile settings
                "makefile.configureOnOpen" = true;

                # Markdown settings
                "markdown-preview-enhanced.codeBlockTheme" = "auto.css";
                "markdown-preview-enhanced.enableCriticMarkupSyntax" = true;
                "markdown-preview-enhanced.enableScriptExecution" = true;
                "markdown-preview-enhanced.liveUpdate" = false;
                "markdown-preview-enhanced.mathRenderingOption" = "MathJax";
                "markdown-preview-enhanced.previewTheme" = "github-light.css";
                "markdown.math.enabled" = false;

                # Material Icon Theme settings
                "material-icon-theme.files.color" = "#90a4ae";
                "material-icon-theme.hidesExplorerArrows" = true;
                "material-icon-theme.opacity" = 1;
                "material-icon-theme.activeIconPack" = "react";

                # Notebook settings
                "notebook.cellFocusIndicator" = "border";
                "notebook.codeActionsOnSave" = {
                  "notebook.source.fixAll" = "explicit";
                  "notebook.source.organizeImports" = "explicit";
                };
                "notebook.consolidatedRunButton" = true;
                "notebook.defaultFormatter" = "charliermarsh.ruff";
                "notebook.diff.overviewRuler" = true;
                "notebook.formatOnSave.enabled" = true;
                "notebook.lineNumbers" = "on";
                "notebook.output.fontFamily" = "FiraCode Nerd Font";
                "notebook.output.fontSize" = 9;
                "notebook.output.scrolling" = true;
                "notebook.stickyScroll.enabled" = true;

                # One Dark Pro settings
                "oneDarkPro.bold" = true;
                "oneDarkPro.italic" = true;

                # Peacock settings
                "peacock.favoriteColors" = [
                  {
                    "name" = "Angular Red";
                    "value" = "#dd0531";
                  }
                  {
                    "name" = "Azure Blue";
                    "value" = "#007fff";
                  }
                  {
                    "name" = "JavaScript Yellow";
                    "value" = "#f9e64f";
                  }
                  {
                    "name" = "Mandalorian Blue";
                    "value" = "#1857a4";
                  }
                  {
                    "name" = "Node Green";
                    "value" = "#215732";
                  }
                  {
                    "name" = "React Blue";
                    "value" = "#61dafb";
                  }
                  {
                    "name" = "Something Different";
                    "value" = "#832561";
                  }
                  {
                    "name" = "Svelte Orange";
                    "value" = "#ff3d00";
                  }
                  {
                    "name" = "Vue Green";
                    "value" = "#42b883";
                  }
                ];

                # PDDL settings
                "pddl.selectedPlanner" =
                  "Planning as a service (solver.planning.domains)";

                # Project Manager settings
                "projectManager.cacheProjectsBetweenSessions" = false;
                "projectManager.confirmSwitchOnActiveWindow" = "always";
                "projectManager.git.baseFolders" = [ "/Users/gat/work/" ];
                "projectManager.sortList" = "Saved";
                "projectManager.tags" =
                  [ "Personal" "Work" "Mantis" "FlipperZero" ];

                # Python settings
                "python.analysis.inlayHints.pytestParameters" = true;
                "python.analysis.packageIndexDepths" = [
                  {
                    "name" = "sklearn";
                    "depth" = 2;
                  }
                  {
                    "name" = "matplotlib";
                    "depth" = 2;
                  }
                  {
                    "name" = "scipy";
                    "depth" = 2;
                  }
                  {
                    "name" = "django";
                    "depth" = 2;
                  }
                  {
                    "name" = "flask";
                    "depth" = 2;
                  }
                  {
                    "name" = "fastapi";
                    "depth" = 2;
                  }
                  {
                    "name" = "inspect_ai";
                    "depth" = 2;
                  }
                ];
                "python.createEnvironment.trigger" = "off";
                "python.linting.pylintArgs" =
                  [ "--extension-pkg-whitelist=cv2" ];
                "python.testing.pytestEnabled" = true;

                # Python Test Explorer settings
                "pythonTestExplorer.testFramework" = "pytest";

                # Red Hat settings
                "redhat.telemetry.enabled" = false;

                # References settings
                "references.preferredLocation" = "view";

                # Remote SSH settings
                "remote.SSH.defaultExtensions" = [
                  "ms-python.vscode-pylance"
                  "ms-python.debugpy"
                  "charliermarsh.ruff"
                  "njpwerner.autodocstring"
                  "rodolphebarbanneau.python-docstring-highlighter"
                  "kevinrose.vsc-python-indent"
                  "ms-toolsai.jupyter"
                  "ms-toolsai.jupyter-renderers"
                  "mechatroner.rainbow-csv"
                  "sbsnippets.pytorch-snippets"
                  "mads-hartmann.bash-ide-vscode"
                  "timonwong.shellcheck"
                  "foxundermoon.shell-format"
                  "mathematic.vscode-pdf"
                  "vitaliymaz.vscode-svg-previewer"
                  "ctcuff.font-preview"
                  "james-yu.latex-workshop"
                  "shd101wyy.markdown-preview-enhanced"
                  "esbenp.prettier-vscode"
                  "mrmlnc.vscode-attrs-sorter"
                  "richie5um2.vscode-sort-json"
                  "2gua.rainbow-brackets"
                  "aaron-bond.better-comments"
                  "alefragnani.project-manager"
                  "peterschmalfeldt.explorer-exclude"
                  "christian-kohler.path-intellisense"
                  "kisstkondoros.vscode-gutter-preview"
                  "eamodio.gitlens"
                  "humao.rest-client"
                  "ms-vscode.makefile-tools"
                  "task.vscode-task"
                  "tamasfe.even-better-toml"
                  "dotenv.dotenv-vscode"
                  "redhat.vscode-yaml"
                  "redhat.vscode-xml"
                  "ibm.output-colorizer"
                  "usernamehw.errorlens"
                  "spmeesseman.vscode-taskexplorer"
                ];
                "remote.SSH.localServerDownload" = "always";
                "remote.SSH.logLevel" = "trace";
                "remote.SSH.showLoginTerminal" = true;
                "remote.SSH.useExecServer" = false;
                "remote.autoForwardPortsSource" = "hybrid";

                # REST Client settings
                "rest-client.fontFamily" = "FiraCode Nerd Font";

                # Ruff settings
                "ruff.lineLength" = 100;

                # Security settings
                "security.promptForLocalFileProtocolHandling" = false;

                # Shell format settings
                "shellformat.useEditorConfig" = true;

                # Svelte settings
                "svelte.enable-ts-plugin" = true;

                # Sync settings
                "sync.gist" = "ebb6d31a5a543247119837ef3098f796";

                # Terminal settings
                "terminal.external.osxExec" = "Ghostty.app";
                "terminal.integrated.allowedLinkSchemes" = [
                  "file"
                  "http"
                  "https"
                  "mailto"
                  "vscode"
                  "vscode-insiders"
                  "docker-desktop"
                ];
                "terminal.integrated.altClickMovesCursor" = true;
                "terminal.integrated.commandsToSkipShell" =
                  [ "language-julia.interrupt" ];
                "terminal.integrated.cursorBlinking" = true;
                "terminal.integrated.cursorStyle" = "line";
                "terminal.integrated.cursorStyleInactive" = "none";
                "terminal.integrated.defaultLocation" = "view";
                "terminal.integrated.defaultProfile.osx" = "zsh";
                "terminal.integrated.enableImages" = true;
                "terminal.integrated.enableMultiLinePasteWarning" = "auto";
                "terminal.integrated.fontFamily" = "FiraCode Nerd Font";
                "terminal.integrated.fontSize" = 10;
                "terminal.integrated.gpuAcceleration" = "on";
                "terminal.integrated.hideOnStartup" = "whenEmpty";
                "terminal.integrated.inheritEnv" = false;
                "terminal.integrated.lineHeight" = 1.05;
                "terminal.integrated.persistentCustomizations" = {
                  "splitTerminals" = [
                    {
                      "command" =
                        "echo 'Terminal 1'; \${command:workbench.action.terminal.new}";
                      "name" = "Terminal 1";
                    }
                    {
                      "command" =
                        "echo 'Terminal 2'; \${command:workbench.action.terminal.new}";
                      "name" = "Terminal 2";
                    }
                  ];
                };
                "terminal.integrated.profiles.osx" = {
                  "zsh" = {
                    "args" = [ "-l" ];
                    "color" = "terminal.ansiBlue";
                    "env" = { "value" = "\${workspaceFolder}/secrets/.env"; };
                    "icon" = "robot";
                    "overrideName" = true;
                    "path" = "zsh";
                  };
                };
                "terminal.integrated.rightClickBehavior" = "default";
                "terminal.integrated.shellIntegration.enabled" = true;
                "terminal.integrated.smoothScrolling" = true;
                "terminal.integrated.splitCwd" = "workspaceRoot";
                "terminal.integrated.stickyScroll.enabled" = true;
                "terminal.integrated.suggest.enabled" = true;
                "terminal.integrated.tabs.enabled" = true;
                "terminal.integrated.tabs.location" = "left";

                # Testing settings
                "testing.automaticallyOpenPeekView" = "never";
                "testing.countBadge" = "off";
                "testing.coverageBarThresholds" = {
                  "green" = 90;
                  "red" = 0;
                  "yellow" = 60;
                };
                "testing.coverageToolbarEnabled" = true;

                # Tinymist (Typst) settings
                "tinymist.formatterMode" = "typstyle";
                "tinymist.preview.invertColors" = "never";
                "tinymist.preview.cursorIndicator" = true;

                # Trunk settings
                "trunk.showPreexistingIssues" = true;

                # Vim settings
                "vim.cursorStylePerMode.insert" = "line";
                "vim.cursorStylePerMode.normal" = "block-outline";
                "vim.cursorStylePerMode.replace" = "underline";
                "vim.cursorStylePerMode.visual" = "block";
                "vim.cursorStylePerMode.visualblock" = "block";
                "vim.cursorStylePerMode.visualline" = "block";
                "vim.disableExtension" = false;
                "vim.enableNeovim" = true;
                "vim.highlightedyank.enable" = true;
                "vim.neovimConfigPath" = "~/.config/nvim/init.vim";
                "vim.neovimUseConfigFile" = false;
                "vim.smartRelativeLine" = true;
                "vim.sneak" = true;
                "vim.statusBarColorControl" = true;

                # VSCode Office settings
                "vscode-office.editorTheme" = "Dracula";
                "vscode-office.openOutline" = false;

                # VSCode Pets settings
                "vscode-pets.petSize" = "small";
                "vscode-pets.petType" = "chicken";
                "vscode-pets.theme" = "castle";
                "vscode-pets.throwBallWithMouse" = true;

                # Window settings
                "window.commandCenter" = false;
                "window.density.editorTabHeight" = "compact";
                "window.openFilesInNewWindow" = "default";
                "window.title" =
                  "🪿\${activeRepositoryName} (\${activeRepositoryBranchName}) \${separator} \${activeEditorMedium}";

                # Workbench settings
                "workbench.accounts.experimental.showEntitlements" = true;
                "workbench.activityBar.location" = "top";
                "workbench.colorCustomizations" = {
                  "editor.lineHighlightBackground" = "#1073cf2d";
                  "editor.lineHighlightBorder" = "#9fced11f";
                  "statusBar.background" = "#005f5f";
                  "statusBar.foreground" = "#ffffff";
                  "statusBarItem.hoverBackground" = "#327e36";
                  "activityBar.background" = "#4B2125";
                  "titleBar.activeBackground" = "#692E33";
                  "titleBar.activeForeground" = "#FDFBFC";
                  "statusBar.noFolderBackground" = "#005f5f";
                  "statusBar.debuggingBackground" = "#005f5f";
                  "statusBar.debuggingForeground" = "#ffffff";
                };
                "workbench.editor.customLabels.enabled" = true;
                "workbench.editor.customLabels.patterns" = {
                  "**/__init__.py" = "📦 \${dirname}/\${filename}";
                  "**/admin.py" = "🔒 \${dirname}/\${filename}";
                  "**/apps.py" = "📦 \${dirname}/\${filename}";
                  "**/extensions.json" = "🧩 \${dirname}/\${filename}";
                  "**/forms.py" = "📝 \${dirname}/\${filename}";
                  "**/keybindings.json" = "⌨️ \${dirname}/\${filename}";
                  "**/models.py" = "📁 \${dirname}/\${filename}";
                  "**/serializers.py" = "👍 \${dirname}/\${filename}";
                  "**/settings.json" = "⚙️ \${dirname}/\${filename}";
                  "**/snippets/*.json" = "📝 \${dirname}/\${filename}";
                  "**/test_*.py" = "🧪 \${filename}";
                  "**/tests.py" = "🧪 \${dirname}/\${filename}";
                  "**/urls.py" = "🔗 \${dirname}/\${filename}";
                  "**/views.py" = "👁️ \${dirname}/\${filename}";
                  "*/.vscode/launch.json" = "🚀 \${dirname}/\${filename}";
                };
                "workbench.editor.labelFormat" = "default";
                "workbench.editor.limit.value" = 4;
                "workbench.editor.tabSizing" = "shrink";
                "workbench.editorAssociations" = {
                  "{git,gitlens}:/**/*.{md,csv,svg}" = "default";
                };
                "workbench.iconTheme" = "material-icon-theme";
                "workbench.layoutControl.enabled" = false;
                "workbench.list.smoothScrolling" = true;
                "workbench.panel.opensMaximized" = "never";
                "workbench.panel.showLabels" = false;
                "workbench.productIconTheme" = "material-product-icons";
              };

              # Extensions from the full VSCode marketplace
              profiles.default.extensions = with pkgs.vscode-marketplace; [
                # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Python Development ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
                ms-python.python
                ms-python.vscode-pylance
                charliermarsh.ruff
                kevinrose.vsc-python-indent
                njpwerner.autodocstring
                rodolphebarbanneau.python-docstring-highlighter
                sbsnippets.pytorch-snippets

                # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Git & Version Control ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
                eamodio.gitlens
                github.vscode-pull-request-github
                github.vscode-github-actions

                # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Language Support ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
                # C/C++
                # ms-vscode.cpptools # Doesn't work on aarch64-darwin
                # ms-vscode.cpptools-extension-pack
                # ms-vscode.cpptools-themes
                # jeff-hykin.better-cpp-syntax
                # ms-vscode.cmake-tools
                # twxs.cmake
                # ms-vscode.makefile-tools
                # cschlosser.doxdocgen
                # hyeon.c-math-viewer

                # JavaScript/TypeScript
                # dsznajder.es7-react-js-snippets
                # pmneo.tsimporter
                # ms-vscode.vscode-typescript-next
                # yoavbls.pretty-ts-errors

                # Web Development
                ms-vscode.live-server
                esbenp.prettier-vscode
                # dbaeumer.vscode-eslint
                # ritwickdey.liveserver

                # Other Languages
                rust-lang.rust-analyzer
                julialang.language-julia
                # shopify.ruby-lsp
                # koichisasada.vscode-rdbg
                # sorbet.sorbet-vscode-extension
                ms-dotnettools.csharp
                # ms-dotnettools.dotnet-interactive-vscode
                # ms-dotnettools.vscode-dotnet-runtime
                ms-vscode.powershell

                # Shell/Bash
                mads-hartmann.bash-ide-vscode
                rogalmic.bash-debug
                timonwong.shellcheck

                # Nix
                jnoortheen.nix-ide

                # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Data & Configuration ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
                redhat.vscode-yaml
                tamasfe.even-better-toml
                dotenv.dotenv-vscode
                mechatroner.rainbow-csv
                grapecity.gc-excelviewer
                richie5um2.vscode-sort-json
                codezombiech.gitignore
                editorconfig.editorconfig

                # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Database ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
                ckolkman.vscode-postgres
                # ms-mssql.mssql
                # ms-mssql.data-workspace-vscode
                # ms-mssql.sql-bindings-vscode

                # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ DevOps & Cloud ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
                ms-azuretools.vscode-docker
                formulahendry.docker-explorer
                # ms-kubernetes-tools.vscode-kubernetes-tools
                # ipedrazas.kubernetes-snippets
                ms-vscode-remote.remote-containers
                ms-vscode-remote.remote-ssh
                ms-vscode-remote.remote-ssh-edit
                ms-vscode-remote.remote-wsl
                ms-vscode.remote-explorer
                ms-vscode.remote-repositories
                ms-vscode.remote-server
                # amazonwebservices.aws-toolkit-vscode
                # aws-scripting-guy.cform
                # github.codespaces
                # mindaro.mindaro
                # mindaro-dev.file-downloader

                # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Documentation & Markdown ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
                yzhang.markdown-all-in-one
                davidanson.vscode-markdownlint
                # bierner.markdown-mermaid
                # yzane.markdown-pdf # Doesn't work on aarch64-darwin
                # chrischinchilla.vscode-pandoc
                # koehlma.markdown-math

                # LaTeX
                james-yu.latex-workshop
                # orangex4.latex-sympy-calculator

                # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Data Science & ML ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
                ms-toolsai.jupyter
                ms-toolsai.jupyter-renderers
                ms-toolsai.vscode-jupyter-cell-tags
                ms-toolsai.vscode-jupyter-powertoys
                ms-toolsai.vscode-jupyter-slideshow
                # ms-toolsai.datawrangler
                # ms-toolsai.tensorboard
                # lov3.sagemath-enhanced

                # R
                # reditorsupport.r
                # rdebugger.r-debugger

                # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Testing & Debugging ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
                # hbenl.vscode-test-explorer
                ms-vscode.test-adapter-converter
                # vitest.explorer
                # hediet.debug-visualizer
                # wallabyjs.quokka-vscode

                # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Code Quality & Formatting ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
                aaron-bond.better-comments
                streetsidesoftware.code-spell-checker
                usernamehw.errorlens
                trunk.io
                # shardulm94.trailing-spaces
                # stkb.rewrap
                lmcarreiro.vscode-smart-column-indenter
                mohammadbaqer.better-folding

                # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Productivity & Organization ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
                alefragnani.project-manager
                # gruntfuggly.todo-tree
                # exodiusstudios.comment-anchors
                # hyperoot.settings-organizer
                peterschmalfeldt.explorer-exclude
                # pflannery.vscode-versionlens
                # salbert.copy-text
                # sirmspencer.vscode-autohide

                # File Operations
                ionutvmi.path-autocomplete
                shinotatwu-ds.file-tree-generator

                # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Themes & UI ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
                dracula-theme.theme-dracula
                pkief.material-icon-theme
                pkief.material-product-icons
                # vscode-icons-team.vscode-icons
                # johnpapa.vscode-peacock
                # leodevbro.blockman
                ibm.output-colorizer

                # Fonts
                # seyyedkhandon.firacode
                # ctcuff.font-preview
                janne252.fontawesome-autocomplete

                # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Specialized Tools ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
                # Office & Documents
                # cweijan.vscode-office
                mathematic.vscode-pdf
                # ms-vscode.hexeditor

                # Graphics & Diagrams
                # hediet.vscode-drawio
                # gera2ld.markmap-vscode
                # vitaliymaz.vscode-svg-previewer

                # API & Web Services
                humao.rest-client
                # postman.postman-for-vscode

                # Automation & Scripting
                # robocorp.robotframework-lsp
                # mark-wiemer.vscode-autohotkey-plus-plus

                # Hardware & IoT
                # cvbenur.ducky-script-lang-vscode
                # xqua.ducky-script-lang-vscode-flipper

                # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Fun & Experimental ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
                # tonybaloney.vscode-pets
                # hoovercj.vscode-power-mode
                # tyriar.luna-paint # Doesn't work.
                # ttoowa.in-your-face-incredible
                # skacekachna.win-opacity

                # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ IntelliSense & AI ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
                # visualstudioexptteam.vscodeintellicode
                # visualstudioexptteam.intellicode-api-usage-examples
                # codeium.codeium

                # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Preview & Visualization ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
                # kisstkondoros.vscode-gutter-preview
                # liamhammett.inline-parameters

                # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Additional Languages & Frameworks ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
                # batisteo.vscode-django
                # antfu.iconify
                myriad-dreamin.tinymist
                surv.typst-math
                vscodevim.vim
                # xadillax.viml
                # ms-vscode.azure-repos
                # deerawan.vscode-dash
              ];
            };
          };
        };

        # Used for backwards compatibility, please read the changelog before changing
        system.stateVersion = 5;

        fonts.packages = [
          pkgs.monaspace
          pkgs.julia-mono
          pkgs.newcomputermodern

          pkgs.fira-code
          pkgs.nerd-fonts.fira-code
          pkgs.fira-math
        ];

        homebrew = {
          enable = true;

          taps = [
            # "homebrew/bundle" # Fails :(
            "charmbracelet/tap"
            "mayowa-ojo/tap"
            "noborus/tap"
          ];

          brews = [
            "tre-command"
            "clipboard"

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

            "git-filter-repo"
            "bfg"
            "commitizen"
            "czg"
            "check-jsonschema"
            "gitleaks"

            "charmbracelet/tap/freeze"
            "vhs"
            "huggingface-cli"

            # Security tools not in nixpkgs
            "fcrackzip"

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
            # "firefox"
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
            "freedom"
            "zotero"
            # "lastpass"
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
            "orbstack"
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
            expose-animation-duration = 5.0e-2;
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
            ShowDate = 0;
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
            ApplePressAndHoldEnabled =
              false; # Supposedly for holding key for accent
            "com.apple.keyboard.fnState" =
              false; # I don't remember what this is
            # AppleKeyboardUIMode = 3; # I don't remember what this is
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
    in {
      darwinConfigurations."gatty" =
        nix-darwin.lib.darwinSystem { modules = [ configuration ]; };
    };
}
