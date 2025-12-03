{ pkgs }: {
  # Shell & Navigation
  atuin = {
    enable = true;
    enableZshIntegration = true;
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
    enableZshIntegration = true;
    enableNushellIntegration = true;
    extraOptions = [ "--width=100" "--group-directories-first" "--all" ];
    git = true;
    icons = "auto";
    theme = "dracula";
  };
  jq.enable = true;
  jqp.enable = true;
  tealdeer.enable = true;
  fzf.enable = true;
  fd.enable = true;
  starship = {
    enable = true;
    enableZshIntegration = true;
    settings = import ./starship-config.nix;
  };
  yazi.enable = true;
  zoxide = {
    enable = true;
    enableBashIntegration = true;
  };
  tex-fmt.enable = true;
  sqls.enable = true;
  readline.enable = true;

  # Additional terminal programs
  zed-editor.enable = true;

  pandoc.enable = true;
  ruff = {
    enable = true;
    settings = { };
  };

  # System Monitoring & Utilities
  btop.enable = true;
  fastfetch = {
    enable = true;
    settings = import ./fastfetch-config.nix;
  };
  less.enable = true;
  topgrade = {
    # https://github.com/topgrade-rs/topgrade/blob/main/config.example.toml
    enable = true;
    settings = {
      misc.disable = [
        "nix"
        "chezmoi"
        "node"
        "pnpm"
        "bun"
        "github_cli_extensions"
        "uv"
        "poetry"
      ];
      commands = {
        "Upgrade Determinate Nix" = "sudo determinate-nixd upgrade";
      };
    };
  };

  # Terminal Multiplexers & Session Management
  zellij = {
    enable = true;
    enableZshIntegration = true;
  };
  tmux.enable = true;

  # Development Tools
  git = {
    enable = true;
    ignores = [ ".DS_Store" ];
    lfs.enable = true;
    settings = {
      user.email = "GatlenCulp@gmail.com";
      user.name = "GatlenCulp";
      init.defaultBranch = "main";
      # https://pre-commit.com/#automatically-enabling-pre-commit-on-repositories
      # TODO: Write the ~/.git-template dir using nix
      init.templateDir = "~/.git-template";
    };
  };

  delta = {
    enable = true;
    enableGitIntegration = true;
    enableJujutsuIntegration = true;
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
  bun = {
    enable = true;
    enableGitIntegration = true;
  };
  mise = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
  };
  nh.enable = true;
  nix-index = 
    {
      enable = true;
      enableBashIntegration = true;
    };
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

  # Network & Security
  ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = { forwardAgent = false; addKeysToAgent = "no"; compression = false; serverAliveInterval = 0; serverAliveCountMax = 3; hashKnownHosts = false; userKnownHostsFile = "~/.ssh/known_hosts"; controlMaster = "no"; controlPath = "~/.ssh/master-%r@%n:%p"; controlPersist = "no"; };


    extraConfig = ''
      Include ~/.ssh/align.ssh
      Include ~/.ssh/metr.ssh
      Include ~/.ssh/extra.ssh
    '';
  };

  go.enable = true;

  # grep.enable = true; #not available?
}
