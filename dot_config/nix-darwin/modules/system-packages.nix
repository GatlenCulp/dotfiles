{ pkgs }:
with pkgs; [
  # Core Development Tools
  lunarvim
  nixfmt-classic
  nixpkgs-fmt

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

  # Development Utilities
  act
  actionlint
  awscli
  chezmoi
  dvc-with-remotes
  go-task
  shellcheck
  shfmt
  terraform
  tldr

  # File Operations & Utilities
  brotli
  curl
  gnutar
  gnugrep
  poppler
  xz

  # Networking & Security
  aircrack-ng
  john
  nmap
  openvpn
  socat
  sqlmap
  tcpflow
  tcpreplay
  wireshark

  # Document Processing & Data
  pandoc
  sqlite
  taplo
  typst
  typstyle

  # Miscellaneous
  git-lfs
  neo-cowsay
]


