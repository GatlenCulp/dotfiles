{ pkgs }:

with pkgs.vscode-marketplace; [
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
  # Web Development
  ms-vscode.live-server
  esbenp.prettier-vscode

  # Other Languages
  rust-lang.rust-analyzer
  julialang.language-julia
  ms-dotnettools.csharp
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

  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ DevOps & Cloud ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
  ms-azuretools.vscode-docker
  formulahendry.docker-explorer
  ms-vscode-remote.remote-containers
  ms-vscode-remote.remote-ssh
  ms-vscode-remote.remote-ssh-edit
  ms-vscode-remote.remote-wsl
  ms-vscode.remote-explorer
  ms-vscode.remote-repositories
  ms-vscode.remote-server

  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Documentation & Markdown ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
  yzhang.markdown-all-in-one
  davidanson.vscode-markdownlint

  # LaTeX
  james-yu.latex-workshop

  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Data Science & ML ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
  ms-toolsai.jupyter
  ms-toolsai.jupyter-renderers
  ms-toolsai.vscode-jupyter-cell-tags
  ms-toolsai.vscode-jupyter-powertoys
  ms-toolsai.vscode-jupyter-slideshow

  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Testing & Debugging ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
  ms-vscode.test-adapter-converter

  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Code Quality & Formatting ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
  aaron-bond.better-comments
  streetsidesoftware.code-spell-checker
  usernamehw.errorlens
  trunk.io
  lmcarreiro.vscode-smart-column-indenter
  mohammadbaqer.better-folding

  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Productivity & Organization ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
  alefragnani.project-manager
  peterschmalfeldt.explorer-exclude

  # File Operations
  ionutvmi.path-autocomplete
  shinotatwu-ds.file-tree-generator

  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Themes & UI ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
  dracula-theme.theme-dracula
  pkief.material-icon-theme
  pkief.material-product-icons
  ibm.output-colorizer

  # Fonts
  janne252.fontawesome-autocomplete

  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Specialized Tools ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
  mathematic.vscode-pdf
  humao.rest-client

  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Additional Languages & Frameworks ━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
  myriad-dreamin.tinymist
  surv.typst-math
  vscodevim.vim
]
