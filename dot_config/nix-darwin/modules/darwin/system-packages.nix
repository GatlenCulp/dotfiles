{ pkgs }:
with pkgs; [
  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Development ━━━━━━━━━━━━━━━━━━━━━━━━━━━

  # Editors & Nix tooling
  claude-code
  code-cursor
  lunarvim
  nixd
  nixdoc
  nixfmt-classic
  nixpkgs-fmt

  # Languages & Runtimes
  cargo
  clippy
  cookiecutter
  go
  nodejs_24
  pylint
  python3
  ruby
  rustc

  # Build, Test, Format & Dev Tools
  act
  actionlint
  biome
  chezmoi
  cruft
  devcontainer
  dvc-with-remotes
  go-task
  graphviz
  hadolint
  just
  mdformat
  ov
  powershell
  pyright
  rich-cli
  shellcheck
  shfmt
  subversion # Used for downloading individual github directories
  terraform
  tldr
  tre
  warp-terminal
  yo
  awscli

  # ━━━━━━━━━━━━━━━━━━━━━━━━ Git & Version Control ━━━━━━━━━━━━━━━━━━━━━━━━
  bfg-repo-cleaner
  check-jsonschema
  commitizen
  git-credential-manager
  git-filter-repo
  gitkraken
  git-lfs
  gitleaks

  # ━━━━━━━━━━━━━━━━━━━━━ System, File & Compression ━━━━━━━━━━━━━━━━━━━━━
  brotli
  curl
  gnugrep
  gnutar
  poppler
  xz

  # ━━━━━━━━━━━━━━━━━━━━━━━ Networking & Security ━━━━━━━━━━━━━━━━━━━━━━━
  # Networking
  dns2tcp
  nmap
  openvpn
  socat
  sshs
  syncthing
  tcpflow
  tcpreplay
  xxh
  # Security
  aircrack-ng
  fcrackzip
  john
  knockpy
  metasploit
  sqlmap
  wireshark

  # ━━━━━━━━━━━━━━━━━━━━━━━ Media, Docs & Data ━━━━━━━━━━━━━━━━━━━━━━━
  # Creative & Media
  blender
  charm-freeze
  vhs
  # Documents, Markup & Data
  pandoc
  sqlite
  taplo
  typst
  typstyle

  # ━━━━━━━━━━━━━━━━━━━━━━━━━ Applications ━━━━━━━━━━━━━━━━━━━━━━━━━
  # Browsers
  brave
  google-chrome
  tor
  # Communication
  discord
  slack
  zoom-us
  # Productivity
  bartender
  raycast
  spotify
  tailscale
  zotero

  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Miscellaneous ━━━━━━━━━━━━━━━━━━━━━━━━━━━
  neo-cowsay

  # ━━━━━━━━━━━━━━━━━━━━━━━ Unsupported on darwin (future) ━━━━━━━━━━━━━━━━━━━━━━━
  # Commented-out packages currently unavailable or broken on darwin. Keep for future enablement.
  # minecraft            # broken on darwin
  # notion               # unsupported on darwin
  # obs-studio           # unsupported on darwin
  # clipgrab             # unsupported on darwin
  # postman              # broken on darwin
  # ghostty              # broken on darwin
  # netron               # unsupported on darwin
  # signal-desktop       # unsupported on darwin
  # ucspi-tcp            # unsupported on darwin
  # whatsapp-for-mac     # broken on darwin
  # zrok                 # unsupported on darwin

  # ━━━━━━━━━━━━━━━━━━━━━━━ Not packaged (future) ━━━━━━━━━━━━━━━━━━━━━━━
  # Items not currently available in nixpkgs/brew but tracked for later.
  # orbstack             # not packaged in nixpkgs
  # Comet by Perplexity  # not in nixpkgs or brew
]

