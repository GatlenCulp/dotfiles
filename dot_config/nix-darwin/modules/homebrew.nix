{
  enable = true;
  taps = [ "charmbracelet/tap" "mayowa-ojo/tap" "noborus/tap" ];

  brews = [
    # Core CLI
    "clipboard"
    "mayowa-ojo/tap/chmod-cli"
    "ov"
    "rich"
    "tre-command"

    # Development
    "biome"
    "cruft"
    "devcontainer"
    "flit"
    "hadolint"
    "mdformat"
    "pyright"
    "yo"

    # Git & VCS
    "bfg"
    "check-jsonschema"
    "commitizen"
    "czg"
    "git-filter-repo"
    "gitleaks"

    # Networking
    "dns2tcp"
    "knock"
    "sshs"
    "syncthing"
    "ucspi-tcp"
    "xxh"
    "zrok"

    # Creative & Media
    "charmbracelet/tap/freeze"
    "huggingface-cli"
    "vhs"

    # TeX & Docs
    "latexindent"
    "tex-fmt"

    # Security & Archive
    "fcrackzip"
    "gnu-tar"
  ];

  casks = [
    # Browsers
    "brave-browser"
    "google-chrome"
    "tor-browser"

    # Development
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

    # Productivity & Utilities
    "applite"
    "bartender"
    "flux"
    "raycast"
    "tailscale"

    # Office & Knowledge
    "dropbox"
    "freedom"
    "microsoft-auto-update"
    "microsoft-office"
    "notion"
    "notion-calendar"
    "spotify"
    "zotero"

    # Security & Terminals
    "burp-suite"
    "ghostty"
    "metasploit"
    "powershell"
    "protonvpn"
    "qflipper"
    "warp"

    # Gaming
    "epic-games"
    "gog-galaxy"
    "minecraft"
    "steam"

    # AI
    "claude"
    "claude-code"

    # Fonts
    "font-nova-round"
  ];

  masApps = {
    "image2icon" = 992115977;
    Xcode = 497799835;
    # "1Password for Safari" = 1569813296;
  };
}


