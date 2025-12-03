{ pkgs }:

with pkgs.vscode-marketplace;
let
  # Profiles. Select subsets later; for now we concatenate them all.
  profiles = {
    general = [
      editorconfig.editorconfig
      codezombiech.gitignore
      usernamehw.errorlens
      streetsidesoftware.code-spell-checker
      aaron-bond.better-comments
      alefragnani.project-manager
      peterschmalfeldt.explorer-exclude
      ibm.output-colorizer
      mohammadbaqer.better-folding
      pflannery.vscode-versionlens
      ms-vscode.makefile-tools
    ];

    themes = [
      dracula-theme.theme-dracula
      pkief.material-icon-theme
      pkief.material-product-icons
    ];

    python = [
      ms-python.python
      # ms-pyright.pyright # Redundant, anysphere has their own version
      ms-python.vscode-pylance # Redundant?
      ms-python.debugpy
      charliermarsh.ruff # redundant?
      kevinrose.vsc-python-indent
      njpwerner.autodocstring
      rodolphebarbanneau.python-docstring-highlighter
      sbsnippets.pytorch-snippets
      ms-python.vscode-python-envs
      ms-python.gather
      # twixes.pypi-assistant
    ];

    typst = [
      myriad-dreamin.tinymist
      surv.typst-math
    ];

    web = [
      biomejs.biome
      ms-vscode.live-server
      esbenp.prettier-vscode
      svelte.svelte-vscode
      bradlc.vscode-tailwindcss
      vitest.explorer
      ecmel.vscode-html-css
      zignd.html-css-class-completion
      mkaufman.htmlhint
      tht13.html-preview-vscode
      samuelcolvin.jinjahtml
      wholroyd.jinja
      ms-vscode.vscode-typescript-next
      christian-kohler.npm-intellisense
      # YoavBls.pretty-ts-errors # not available
    ];

    rust = [ rust-lang.rust-analyzer ];

    julia = [ julialang.language-julia ];

    csharp = [ ];

    powershell = [ ms-vscode.powershell ];

    shell = [
      mads-hartmann.bash-ide-vscode
      rogalmic.bash-debug
      timonwong.shellcheck
      foxundermoon.shell-format
      jetmartin.bats
      xadillax.viml
      # xjnoortheen.xonsh # Not available
    ];

    nix = [ jnoortheen.nix-ide ];

    data-config = [
      redhat.vscode-yaml
      redhat.vscode-xml
      tamasfe.even-better-toml
      dotenv.dotenv-vscode
      mikestead.dotenv
      mechatroner.rainbow-csv
      grapecity.gc-excelviewer
      richie5um2.vscode-sort-json
      remcohaszing.schemastore
      dvirtz.parquet-viewer
      # ZainChen.json # Not available
      kdl-org.kdl
      cweijan.vscode-office
      # quarto.quarto # Idk if I need this
    ];

    database = [
      ckolkman.vscode-postgres
      mtxr.sqltools
      randomfractalsinc.duckdb-sql-tools
      ms-toolsai.datawrangler
    ];

    r-lang = [
      REditorSupport.r
      REditorSupport.r-syntax
    ];

    devops = [
      ### Containers
      ms-azuretools.vscode-docker
      formulahendry.docker-explorer
      jeff-hykin.better-dockerfile-syntax
      ms-kubernetes-tools.vscode-kubernetes-tools
      ipedrazas.kubernetes-snippets
      ### Remote
      ms-vscode-remote.remote-wsl
      ms-vscode.remote-repositories
      ms-vscode.remote-server
      ### Infrastructure as Code (IaC)
      redhat.ansible
      amazonwebservices.aws-toolkit-vscode
      hashicorp.terraform
      ### CI/CD & Testing
      exiasr.hadolint
      ### Misc
      philnash.ngrok-for-vscode
      # anysphere.remote-containers # Doesn't work on cursor
      # Postman.postman-for-vscode # Not in vscode-extensions
    ];

    docs = [
      # yzhang.markdown-all-in-one
      shd101wyy.markdown-preview-enhanced
      davidanson.vscode-markdownlint
    ];

    latex = [ james-yu.latex-workshop ];

    ds-ml = [
      ms-toolsai.jupyter
      ms-toolsai.jupyter-renderers
      ms-toolsai.vscode-jupyter-cell-tags
      ms-toolsai.vscode-jupyter-powertoys
      ms-toolsai.vscode-jupyter-slideshow
      ukaisi.inspect-ai
    ];

    testing = [ ms-vscode.test-adapter-converter ];

    code-quality = [
      trunk.io
      lmcarreiro.vscode-smart-column-indenter
    ];

    file-ops = [
      ionutvmi.path-autocomplete
      christian-kohler.path-intellisense
      shinotatwu-ds.file-tree-generator
      kisstkondoros.vscode-gutter-preview
      # YuTengjing.vscode-archive # Not available
    ];

    git = [
      eamodio.gitlens
      github.vscode-pull-request-github
      github.vscode-github-actions
      # SanjulaGanepola.github-local-actions # Not in vscode-extensions
    ];

    lisp = [
      evzen-wybitul.magic-racket
      sjhuangx.vscode-scheme
    ];

    lean = [
      leanprover.lean4
    ];

    ruby = [
      rubocop.vscode-rubocop
      # Shopify.ruby-lsp # Not available
      sorbet.sorbet-vscode-extension
    ];

    specialized = [
      mathematic.vscode-pdf
      mathematic.vscode-latex
      humao.rest-client
      # tonybaloney.vscode-pets
      # hediet.vscode-drawio
      vitaliymaz.vscode-svg-previewer
      vincent-templier.vscode-netron
      ban.troff
      # jan-dolejsi.pddl
      # WakaTime.vscode-wakatime # Not available
    ];

    fonts = [
      janne252.fontawesome-autocomplete
      # SeyyedKhandon.firacode
      ctcuff.font-preview
    ];

    vim = [
      vscodevim.vim
    ];

    cpp = [
      jeff-hykin.better-cpp-syntax
      ms-vscode.cpptools-themes
      cschlosser.doxdocgen
    ];

    cloud = [
      aws-scripting-guy.cform
      # GitHub.codespaces
      github.remotehub
      ms-vsliveshare.vsliveshare
    ];

    debugging = [
      hediet.debug-visualizer
      ms-vscode.hexeditor
    ];

    snippets-templates = [
      adpyke.codesnap
      helixquar.asciidecorator
      dsznajder.es7-react-js-snippets
      abusaidm.html-snippets
    ];

    ui-ux = [
      alefragnani.bookmarks
      antfu.iconify
      arthurlobo.vscode-doom
      exodiusstudios.comment-anchors
      stackbreak.comment-divider
      johnpapa.vscode-peacock
      xiaoluoboding.vscode-folder-size
    ];

    utilities = [
      atishay-jain.all-autocomplete
      formulahendry.auto-rename-tag
      salbert.copy-text
      mrmlnc.vscode-duplicate
      liamhammett.inline-parameters
      elagil.pre-commit-helper
      louiswt.regexp-preview
      stkb.rewrap
      griimick.vhs
    ];

    hardware = [
      cvbenur.ducky-script-lang-vscode
      xqua.ducky-script-lang-vscode-flipper
    ];

    security = [
      wscats.cors-browser
    ];

    remote = [
      ms-vscode-remote.remote-containers
      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-ssh-edit
      ms-vscode.remote-explorer
    ];

  };

  # Default selection: include all profiles to preserve current behavior.
  selected = with profiles; [
    general
    themes
    python
    typst
    web
    rust
    # julia
    csharp
    powershell
    shell
    nix
    data-config
    database
    devops
    docs
    latex
    # lisp
    ds-ml
    testing
    code-quality
    file-ops
    git
    specialized
    fonts
    vim
    lean
    # ruby
    # cpp
    cloud
    debugging
    # snippets-templates
    ui-ux
    utilities
    # hardware
    security
    remote
  ];
in
builtins.concatLists selected
