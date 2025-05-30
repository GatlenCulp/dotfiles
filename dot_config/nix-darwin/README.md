# nix-darwin

This will install nix-darwin if you don't already have it.
```bash
nix run nix-darwin -- switch --flake ~/.config/nix-darwin
```

Everything should happen or be imported into `flake.nix`

<!-- - `darwin.nix` -- nix-darwin configuration (Mac App Store apps,  Homebrew, etc.) -->

<!-- This will also build if not already existed.
darwin-rebuild switch --flake ~/.config/nix-darwin#gatty-2 -->

NixOS inspired setup:
https://github.com/notusknot/dotfiles-nix

And a nix-darwin setup:
https://github.com/heywoodlh/nix-darwin-flake


## TODO

**Mac Settings**
```bash
# Disable startup sound
sudo nvram StartupMute=%01
```

**LVIM**
```bash
# LVIM
# Make sure this script runs after package installation
if ! command -v lvim >/dev/null 2>&1; then
    LV_BRANCH='release-1.4/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.4/neovim-0.9/utils/installer/install.sh)
else
    echo "LunarVim is already installed, skipping installation"
fi
```

**VSCode Extensions**
```bash
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
#                           How to install                           #
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ #

# To see what is already installed use: brew list
# To install: brew bundle --no-lock --file={{ .chezmoi.sourceDir }}/.Brewfile

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ Taps ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
## Homebrew Core
tap "homebrew/bundle"            # Bundler for Homebrew
# tap "homebrew/test-bot"          # Testing tools for Homebrew

## Personal
# tap "gatlenculp/mopman"
# tap "gatlenculp/vivaria"

## Custom package repositories
tap "charmbracelet/tap"          # Terminal tools and TUIs
tap "mayowa-ojo/tap"             # Custom tools
# tap "nat-n/poethepoet"           # Task runner for Python projects
tap "noborus/tap"                # Terminal tools
# tap "ynqa/tap"                   # Development tools
# tap "konradsz/igrep"             # Interactive grep (idk if I like)


# ━━━━━━━━━━━━━━━━━━━━━━━━ Core Development ━━━━━━━━━━━━━━━━━━━━━━━━ #

{{ if .python }}
# ─────────────────────── Python Environment ──────────────────────── #
## Package Management
brew "uv"                        # Fast Python package installer and resolver
cask "miniconda"                 # Minimal Conda installer
# brew "poetry"
# brew "pipx"

## Development Tools
brew "flit"                      # Simplified Python package publishing

## Quality Assurance
brew "pylint"                    # Python code static checker
brew "pyright"                   # Static type checker for Python
brew "ruff"                      # Fast Python linter and code formatter

## Project Tools
brew "cookiecutter"              # Project template tool
brew "cruft"                     # Project template manager
# brew "nat-n/poethepoet/poethepoet" # Task runner for Python projects

{{ end }}

# ───────────────────────── Core Languages ───────────────────────── #

{{ if .node }}
## Web Development
brew "node"                      # JavaScript runtime environment
brew "typescript"                # Typed superset of JavaScript
brew "biome"                     # Toolchain for web projects
cask "dotnet-sdk"                # SDK for Microsoft's .NET platform
{{ end }}

## System Programming
{{ if .rust }}
brew "rust"                      # Systems programming language
{{ end }}

{{ if .go }}
brew "go"                        # Open source programming language
{{ end }}

# ───────────────────────────── Editing ──────────────────────────── #

## Git tools
brew "git"                       # Version control system
brew "gh"                        # GitHub CLI tool
brew "pre-commit"                # Git hooks manager

## Shells
brew "bash"                      # Bourne Again SHell
brew "zsh"# Z shell, a modern alternative to bash

## Editor
{{ if .enhanced_shell }}
brew "neovim"                    # Modernized Vim text editor
{{ end }}

## Shell Enhancements
brew "oh-my-posh"                # Cross-shell prompt theme engine
{{ if .enhanced_shell }}
brew "zsh-autosuggestions"       # Fish-like autosuggestions for zsh
brew "zsh-syntax-highlighting"   # Fish-like syntax highlighting for zsh
brew "bash-completion@2"         # Programmable completion for Bash

# ─────────────────────── Command Line Tools ─────────────────────── #
## File Operations
brew "eza"                       # `eza <- ls` Modern replacement for ls
brew "bat"                       # `bat <- cat` Cat with syntax highlighting
brew "tre-command"               # `tre` Tree command with git integration
brew "clipboard"                 # `cb <- pbcopy` Command line clipboard tool 

## File
brew "xz"                        # Data compression tool
brew "gnu-tar"                   # GNU version of tar archiving utility

## Search & Navigation
brew "zoxide"                    # `z <- cd` Smarter cd command (or zi w/ fzf)
brew "fzf"                       # `fzf` Fuzzy finder (Use zi though)
brew "grep"                      # `grep` GNU grep (macOS Version is Old)
brew "noborus/tap/ov"            # `ov` Terminal pager
# brew "konradsz/igrep/igrep"      # `ig` Interactive grep tool (idk if I like)
# brew "ynqa/tap/sigrs"            # Interactive grep for streaming

## System Monitoring & Management
brew "btop"                      # `btop <- top` System monitor
brew "fastfetch"                 # `fastfetch` System information tool
brew "mayowa-ojo/tap/chmod-cli"  # `chmod-cli` chmod permission manager

## Network & Remote Tools
brew "sshs"                      # SSH connection TUI
brew "syncthing"                 # File synchronization tool (rsync-like)
brew "xxh"                       # SSH w/ shell transfer
brew "openssh"                   # OpenSSH remote login client (macOS Version is Old)
brew "zrok"                      # Reverse proxy for sharing localhost
brew "curl" # Get a file from an HTTP, HTTPS or FTP server (macOS Version is Old)
# cask "ngrok"                     # Reverse proxy for sharing localhost

## Development Tools
brew "yo"                        # `yo` Scaffolding tool for web apps
brew "rich"                      # `rich` Rich text and styling for terminal output

## Productivity & Assistance
brew "thefuck"                   # `fuck` Command correction tool
brew "tldr"                      # `tldr` Simplified man pages
{{ end }}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━ Applications ━━━━━━━━━━━━━━━━━━━━━━━━━━ #

{{ if .terminals }}
# ─────────────────────── Terminal Emulators ─────────────────────── #
cask "warp"                      # Modern terminal with AI features
cask "ghostty"                   # Modern, fast, featureful terminal
# cask "iterm2"                    # Terminal emulator for macOS
# cask "itermai"                   # AI extension for iterm2
{{ end }}

{{ if .browsers }}
# ──────────────────────────── Browsers ──────────────────────────── #
cask "firefox"                   # Mozilla web browser
cask "google-chrome"             # Google's web browser
cask "tor-browser"               # Privacy-focused browser
{{ end }}

{{ if .media }}
# ────────────────────────────── Video ───────────────────────────── #
## Record
cask "obs"                       # Streaming and recording software
cask "loom" # Screen and video recording software

## Model
cask "blender"                   # 3D creation suite

## Edit
cask "adobe-creative-cloud"      # Creative suite from Adobe

## Download
cask "clipgrab"                  # Video downloader and converter

## View
cask "vlc"                       # Media player with wide format support
{{ end }}

{{ if .office }}
# ───────────────────────────── Office ───────────────────────────── #
cask "microsoft-office"          # Microsoft Office suite
cask "microsoft-auto-update"     # Microsoft Office updater
cask "notion"                    # Note-taking and collaboration platform
cask "notion-calendar"           # Calendar app from Notion
cask "dropbox"                   # Cloud storage service

# ────────────────────── Productivity & Health ───────────────────── #
cask "cold-turkey-blocker"       # Website and application blocker
cask "zotero"                    # Reference management software
cask "lastpass"                  # Password manager
cask "flux"                      # Screen color temperature adjuster

# ────────────────────────────── Misc ────────────────────────────── #
cask "spotify"                   # Music streaming service
cask "applite"
# brew "gambit"                    # Game Theory Calculator
{{ end }}

{{ if .communication }}
# ────────────────────────────── Comms ───────────────────────────── #
cask "discord"                   # Voice and text chat platform
cask "messenger"                 # Facebook Messenger desktop client
cask "whatsapp"                  # WhatsApp desktop client
cask "zoom"                      # Video conferencing software
cask "signal"                    # Encrypted messaging app
cask "slack"                     # Team communication platform
{{ end }}

{{ if .games }}
# ────────────────────────────── Games ───────────────────────────── #
cask "epic-games"               # Epic Games Store client
cask "gog-galaxy"               # GOG gaming platform client
cask "steam"                    # Valve's gaming platform
cask "minecraft"                # Popular sandbox game
{{ end }}

{{ if .cybersecurity }}
# ━━━━━━━━━━━━━━━━━━━━━━━━━━ Cybersecurity ━━━━━━━━━━━━━━━━━━━━━━━━━ #
## Frameworks & Suites
cask "metasploit"               # Penetration testing framework
cask "burp-suite"               # Web security testing tool

## Network Analysis & Monitoring
brew "wireshark"                # Network protocol analyzer
brew "tcpflow"                  # TCP flow recorder
brew "tcptrace"                 # TCP connection analysis tool
brew "tcpreplay"                # TCP packet replay tool

## Network Security Tools
brew "aircrack-ng"              # Network security tool suite
brew "dns2tcp"                  # DNS tunneling tool
brew "knock"                    # Port knock sequence sender
brew "socat"                    # Multipurpose relay tool
brew "ucspi-tcp"                # TCP client-server program tools
cask "zenmap" # Multi-platform graphical interface for official Nmap Security Scanner

## Password & Access Tools
brew "hydra"                    # Password cracking tool
brew "john"                     # John the Ripper password cracker
brew "fcrackzip"                # Zip password cracker
brew "sqlmap"                   # SQL injection testing tool
# brew "argon2"                   # Password hashing library and CLI utility

## VPN & Privacy
brew "openvpn"                  # Open source VPN solution

## Hardware Tools
cask "qflipper"                 # Flipper Zero firmware updater
{{ end }}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━ Development ━━━━━━━━━━━━━━━━━━━━━━━━━━ #

{{ if .supporting_languages }}
# ────────────────────── Supporting Languages ────────────────────── #
## Scripting Languages
brew "php"                       # General-purpose scripting language
brew "ruby"                      # Dynamic, object-oriented programming language
brew "perl"                      # Highly capable scripting language
brew "lua"
brew "luajit"

## Academic & Scientific
cask "sage"                      # Mathematics software system
cask "racket"                    # Modern LISP and programming language platform

## LaTeX
{{ if .latex }}
brew "tex-fmt"                  # TeX document formatting system
brew "latexindent"              # Perl script for formatting LaTeX files
{{ end }}

## Markdown
{{ if .markdown }}
brew "mdformat"                 # Markdown formatter
brew "pandoc"                   # Universal document converter
{{ end }}

## Configuration
brew "taplo"                    # TOML toolkit and parser
brew "chezmoi" # Manage your dotfiles across multiple diverse machines, securely

## Misc
brew "prettier"                 # Code formatter for multiple languages
cask "dotnet-sdk"               # SDK for Microsoft's .NET platform
brew "tidy-html5"
{{ end }}

{{ if .containers }}
# ─────────────────────────── Containers ─────────────────────────── #
# brew "docker-completion"        # Docker completion for the terminal
cask "kubernetes-cli"            # Command-line tool for Kubernetes
brew "devcontainer" # Reference implementation for the Development Containers specification
brew "hadolint" # Smarter Dockerfile linter to validate best practices
{{ end }}

# ──────────────────────────── Databases ─────────────────────────── #
{{ if .databases }}
brew "postgresql@16"             # Object-relational database system
brew "sqlite"
{{ end }}

{{ if .shell_utils}}
# ───────────────────────── Shell Utilities ──────────────────────── #
## Terminal Multiplexers
brew "tmux"                      # Terminal session manager (for compatibility)
brew "zellij"                    # Modern terminal multiplexer in Rust (preferred)

## Shell Environments
brew "nushell"                   # Modern shell written in Rust
brew "xonsh"                     # Python-powered shell language
cask "powershell"                # Microsoft's task automation framework

## Shell Development Tools
brew "shellcheck"                # Shell script analysis tool
brew "shfmt"                     # Shell script formatter
{{ end }}

{{ if .git_utils }}
# ────────────────────────── Git Utilities ───────────────────────── #
## Git + Extensions
brew "git-filter-repo"           # History rewriting tool
cask "git-credential-manager"    # Secure Git credential storage
brew "git-lfs"                   # Git extension for large files

## Git Tools
cask "gitkraken"                 # Git GUI client
brew "bfg"                       # Git repository cleaner

## Git Quality Assurance
brew "commitizen"                # Standardized commit message tool
brew "czg"                       # Interactive commitizen CLI
brew "check-jsonschema"          # JSON Schema validation tool
brew "gitleaks"                  # Secret scanning tool
# brew "trufflehog"

## Github Actions
brew "act"                       # Run GitHub Actions locally
brew "actionlint"                # GitHub Actions workflow linter
{{ end }}

{{ if .misc_utils }}
# ────────────────────────────── Misc ────────────────────────────── #
## Task Running
brew "go-task"                   # Task runner / simpler Make alternative

## Cloud
brew "awscli"                    # Amazon Web Services CLI

## API Development
cask "postman"                   # API development environment

## AI
cask "claude"                    # Anthropic's AI assistant
cask "netron"                    # Neural network viewer
brew "huggingface-cli"

## Code Recording
brew "vhs"                       # Terminal recorder and animator
brew "charmbracelet/tap/freeze"  # Generate images of code and terminal output.
{{ end }}

{{ /*
# ─────────────────── Random stuff I may not need ────────────────── #
## Core Libraries
# brew "abseil"                    # C++ library from Google
# brew "icu4c@76"                  # C/C++ and Java libraries for Unicode and globalization
# brew "gmp"                       # GNU Multiple Precision Arithmetic Library
# brew "binutils"                  # GNU binary tools
# brew "pkgconf"                   # Package compiler and linker metadata toolkit
# brew "apr"
# brew "apr-util"
# brew "aribb24" # Library for ARIB STD-B24, decoding JIS 8 bit characters and parsing MPEG-TS
# brew "autoconf" # Automatic configure script builder

## Likely cybersecurity
# brew "binwalk"                   # Firmware analysis tool
# brew "foremost"                  # File carving and recovery tool
# brew "pngcheck"                  # PNG file validator and debugger
# brew "cifer"                     # Automating cipher cracking

## Misc
# brew "re2"                       # Fast, safe alternative to backtracking regex engines
# brew "llvm"                      # LLVM compiler infrastructure
# brew "dex2jar"                   # Android DEX to Java decompiler
# brew "netpbm"                    # Graphics conversion tools
# brew "pdf2svg"                   # PDF to SVG converter

# brew "screen"                    # Classic terminal multiplexer
# brew "c-ares"
# brew "ca-certificates"
# brew "certifi"
# brew "cffi"
# brew "cjson"
# brew "dav1d"
# brew "ffmpeg" Play, record, convert, and stream audio and video
# brew "flac"
# brew "fontconfig"
# brew "freetds"
# brew "frei0r"
# brew "fribidi"
# various lib*
# gd, ghostscript, harfbuzz, highway, imath, jasper, lame, leptonica so many more
# json-c, krb5, libass, tesseract, theora
*/ }}

{{ if .editors }}
# ───────────────────────────── Editors ──────────────────────────── #
cask "visual-studio-code"        # Code editor from Microsoft
cask "cursor"                    # AI-powered code editor
brew "jupyterlab"

# ━━━━━━━━━━━━━━━━━━━━━━━━ VSCode Extensions ━━━━━━━━━━━━━━━━━━━━━━━ #
vscode "076923.python-image-preview"
vscode "aaron-bond.better-comments"
vscode "alefragnani.project-manager"
vscode "almenon.arepl"
vscode "amazonwebservices.aws-toolkit-vscode"
vscode "antfu.iconify"
vscode "aws-scripting-guy.cform"
vscode "batisteo.vscode-django"
vscode "bierner.markdown-mermaid"
vscode "cameron.vscode-pytest"
vscode "charliermarsh.ruff"
vscode "chrischinchilla.vscode-pandoc"
vscode "ckolkman.vscode-postgres"
vscode "codeium.codeium"
vscode "codezombiech.gitignore"
vscode "cschlosser.doxdocgen"
vscode "ctcuff.font-preview"
vscode "cvbenur.ducky-script-lang-vscode"
vscode "cweijan.vscode-office"
vscode "davidanson.vscode-markdownlint"
vscode "dbaeumer.vscode-eslint"
vscode "deerawan.vscode-dash"
vscode "donjayamanne.githistory"
vscode "donjayamanne.python-environment-manager"
vscode "dotenv.dotenv-vscode"
vscode "dracula-theme.theme-dracula"
vscode "dsznajder.es7-react-js-snippets"
vscode "eamodio.gitlens"
vscode "editorconfig.editorconfig"
vscode "esbenp.prettier-vscode"
vscode "exodiusstudios.comment-anchors"
vscode "formulahendry.docker-explorer"
vscode "gera2ld.markmap-vscode"
vscode "github.codespaces"
vscode "github.copilot"
vscode "github.copilot-chat"
vscode "github.remotehub"
vscode "github.vscode-github-actions"
vscode "github.vscode-pull-request-github"
vscode "grapecity.gc-excelviewer"
vscode "graykode.ai-docstring"
vscode "gruntfuggly.todo-tree"
vscode "hbenl.vscode-test-explorer"
vscode "hediet.debug-visualizer"
vscode "hediet.vscode-drawio"
vscode "hoovercj.vscode-power-mode"
vscode "humao.rest-client"
vscode "hyeon.c-math-viewer"
vscode "hyperoot.settings-organizer"
vscode "ibm.output-colorizer"
vscode "ionutvmi.path-autocomplete"
vscode "ipedrazas.kubernetes-snippets"
vscode "james-yu.latex-workshop"
vscode "janne252.fontawesome-autocomplete"
vscode "jeff-hykin.better-cpp-syntax"
vscode "johnpapa.vscode-peacock"
vscode "julialang.language-julia"
vscode "kevinrose.vsc-python-indent"
vscode "kisstkondoros.vscode-gutter-preview"
vscode "koehlma.markdown-math"
vscode "koichisasada.vscode-rdbg"
vscode "leodevbro.blockman"
vscode "liamhammett.inline-parameters"
vscode "littlefoxteam.vscode-python-test-adapter"
vscode "lmcarreiro.vscode-smart-column-indenter"
vscode "lov3.sagemath-enhanced"
vscode "mads-hartmann.bash-ide-vscode"
vscode "mark-wiemer.vscode-autohotkey-plus-plus"
vscode "mathematic.vscode-pdf"
vscode "mechatroner.rainbow-csv"
vscode "mhutchie.git-graph"
vscode "mikestead.dotenv"
vscode "mindaro-dev.file-downloader"
vscode "mindaro.mindaro"
vscode "mohammadbaqer.better-folding"
vscode "ms-azuretools.vscode-docker"
vscode "ms-dotnettools.csharp"
vscode "ms-dotnettools.dotnet-interactive-vscode"
vscode "ms-dotnettools.vscode-dotnet-runtime"
vscode "ms-kubernetes-tools.vscode-kubernetes-tools"
vscode "ms-mssql.data-workspace-vscode"
vscode "ms-mssql.mssql"
vscode "ms-mssql.sql-bindings-vscode"
vscode "ms-pyright.pyright"
vscode "ms-python.black-formatter"
vscode "ms-python.debugpy"
vscode "ms-python.isort"
vscode "ms-python.mypy-type-checker"
vscode "ms-python.pylint"
vscode "ms-python.python"
vscode "ms-python.vscode-pylance"
vscode "ms-toolsai.datawrangler"
vscode "ms-toolsai.jupyter"
vscode "ms-toolsai.jupyter-renderers"
vscode "ms-toolsai.tensorboard"
vscode "ms-toolsai.vscode-jupyter-cell-tags"
vscode "ms-toolsai.vscode-jupyter-powertoys"
vscode "ms-toolsai.vscode-jupyter-slideshow"
vscode "ms-vscode-remote.remote-containers"
vscode "ms-vscode-remote.remote-ssh"
vscode "ms-vscode-remote.remote-ssh-edit"
vscode "ms-vscode-remote.remote-wsl"
vscode "ms-vscode.azure-repos"
vscode "ms-vscode.cmake-tools"
vscode "ms-vscode.cpptools"
vscode "ms-vscode.cpptools-extension-pack"
vscode "ms-vscode.cpptools-themes"
vscode "ms-vscode.hexeditor"
vscode "ms-vscode.live-server"
vscode "ms-vscode.makefile-tools"
vscode "ms-vscode.powershell"
vscode "ms-vscode.remote-explorer"
vscode "ms-vscode.remote-repositories"
vscode "ms-vscode.remote-server"
vscode "ms-vscode.test-adapter-converter"
vscode "ms-vscode.vscode-typescript-next"
vscode "njpwerner.autodocstring"
vscode "orangex4.latex-sympy-calculator"
vscode "peterschmalfeldt.explorer-exclude"
vscode "pflannery.vscode-versionlens"
vscode "pkief.material-icon-theme"
vscode "pkief.material-product-icons"
vscode "pmneo.tsimporter"
vscode "postman.postman-for-vscode"
vscode "rdebugger.r-debugger"
vscode "redhat.vscode-yaml"
vscode "reditorsupport.r"
vscode "richie5um2.vscode-sort-json"
vscode "ritwickdey.liveserver"
vscode "robocorp.robotframework-lsp"
vscode "rodolphebarbanneau.python-docstring-highlighter"
vscode "rogalmic.bash-debug"
vscode "rust-lang.rust-analyzer"
vscode "salbert.copy-text"
vscode "sbsnippets.pytorch-snippets"
vscode "seyyedkhandon.firacode"
vscode "shardulm94.trailing-spaces"
vscode "shinotatwu-ds.file-tree-generator"
vscode "shopify.ruby-lsp"
vscode "sirmspencer.vscode-autohide"
vscode "skacekachna.win-opacity"
vscode "sorbet.sorbet-vscode-extension"
vscode "stkb.rewrap"
vscode "streetsidesoftware.code-spell-checker"
vscode "surv.typst-math"
vscode "tamasfe.even-better-toml"
vscode "timonwong.shellcheck"
vscode "tonybaloney.vscode-pets"
vscode "ttoowa.in-your-face-incredible"
vscode "twxs.cmake"
vscode "tyriar.luna-paint"
vscode "usernamehw.errorlens"
vscode "visualstudioexptteam.intellicode-api-usage-examples"
vscode "visualstudioexptteam.vscodeintellicode"
vscode "vitaliymaz.vscode-svg-previewer"
vscode "vitest.explorer"
vscode "vscode-icons-team.vscode-icons"
vscode "vscodevim.vim"
vscode "waderyan.gitblame"
vscode "wallabyjs.quokka-vscode"
vscode "xadillax.viml"
vscode "xqua.ducky-script-lang-vscode-flipper"
vscode "yoavbls.pretty-ts-errors"
vscode "yzane.markdown-pdf"
vscode "yzhang.markdown-all-in-one"
vscode "ziyasal.vscode-open-in-github"
{{ end }}

{{ if .fonts }}
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ Fonts ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ #
cask "font-blackout"             # Sans-serif display font
cask "font-computer-modern"      # Computer Modern font family
cask "font-fira-code"            # Monospace font with programming ligatures
cask "font-fira-code-nerd-font"  # Fira Code with added icons
cask "font-noto-naskh-arabic"    # Google Noto font for Arabic script
cask "font-noto-serif"           # Google Noto serif font family
cask "font-noto-serif-bengali"   # Google Noto font for Bengali script
cask "font-noto-serif-cjk"       # Google Noto font for CJK languages
cask "font-noto-serif-devanagari" # Google Noto font for Devanagari script
cask "font-noto-serif-hebrew"    # Google Noto font for Hebrew script
cask "font-noto-serif-thai"      # Google Noto font for Thai script
cask "font-nova-round"           # Rounded sans-serif font
{{ end }}
```

Add everything from here:
https://github.com/GatlenCulp/macos_setup/tree/main/src/macos

- Setting default apps with Duti
- Hide All Desktop Icons
- Set dock
```bash
echo "Setting Dock preferences..."

# Position the Dock on the left
defaults write com.apple.dock "orientation" -string "left"

# Set Dock size (0 to 1)
defaults write com.apple.dock tilesize -int 20

# Do not show recent applications in Dock
defaults write com.apple.dock "show-recents" -bool "false"

# Show only active applications in Dock
defaults write com.apple.dock static-only -bool true

# Restart the Dock to apply changes
killall Dock
```
- Finder Preferences
```bash
#!/user/bin/env bash

echo "Setting Finder preferences..."

# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Disable the "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Show all filename extensions
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"

# Set fast key repeat rate
defaults write -g KeyRepeat -int 2

# Set short delay until repeat
defaults write -g InitialKeyRepeat -int 15

# Restart Finder to apply changes
killall Finder
```


- Add shortcuts
```text
Go to shortcuts, add a shortcut for finder and add to quick actions, then you can make
a shortcut with...

open -a Warp "$*"

or whatever else to launch a program from file or folder.

Make sure to the finder context as a file path and as an argument to the shell command
```

- Set clock to 24 hours

- Set theme
```bash
#!/user/bin/env bash

echo "Setting desktop preferences..."

abs_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# Set wallpaper
osascript -e "tell application 'Finder' to set desktop picture to POSIX file \'${abs_dir}/wallpaper.jpg\'"

# Enable Dark Mode
defaults write -g AppleInterfaceStyle Dark
```

- Install Rosetta
- Bartender settings or smthn