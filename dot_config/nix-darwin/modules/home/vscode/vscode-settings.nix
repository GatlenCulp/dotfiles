{
  "workbench.colorTheme" = "Dracula Theme";
  "C_Cpp.updateChannel" = "Insiders";

  # Language-specific formatting settings
  "[css]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
  "[eval-log]" = { };
  "[html]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
  "[javascript]"."editor.defaultFormatter" = "biomejs.biome";
  "[json]" = {
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
    "editor.tabSize" = 2;
    "editor.wordWrap" = "on";
  };
  "[jsonc]"."editor.defaultFormatter" = "vscode.json-language-features";
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
  "[ruby]" = {
    "editor.defaultFormatter" = "Shopify.ruby-lsp";
    "editor.formatOnSave" = true;
    "editor.formatOnType" = true;
    "editor.insertSpaces" = true;
    "editor.semanticHighlighting.enabled" = true;
    "editor.tabSize" = 2;
    "editor.wordSeparators" = ''`~@#$%^&*()-=+[{]}\|;:'",.<>/'';
  };
  "[shellscript]"."editor.defaultFormatter" = "mads-hartmann.bash-ide-vscode";
  "[svelte]"."editor.defaultFormatter" = "svelte.svelte-vscode";
  "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
  "[yaml]"."editor.defaultFormatter" = "redhat.vscode-yaml";
  "[typst]" = {
    "editor.wordSeparators" = ''`~!@#$%^&*()=+[{]}\|;:'",.<>/?'';
    "editor.formatOnSave" = true;
  };
  "[typst-code]"."editor.wordSeparators" = ''`~!@#$%^&*()=+[{]}\|;:'",.<>/?'';
  "[pddl]"."editor.defaultFormatter" = "jan-dolejsi.pddl";

  # Editor Core Settings
  "editor.acceptSuggestionOnEnter" = "off";
  "editor.fontFamily" = "FiraCode Nerd Font";
  "editor.fontLigatures" = true;
  "editor.formatOnType" = true;
  "editor.cursorSmoothCaretAnimation" = "on";
  "editor.wordWrap" = "bounded";
  "editor.wordWrapColumn" = 100;
  "editor.minimap.enabled" = false;
  "editor.inlineSuggest.enabled" = true;

  # Terminal Settings
  "terminal.external.osxExec" = "Ghostty.app";
  "terminal.integrated.fontFamily" = "FiraCode Nerd Font";
  "terminal.integrated.fontSize" = 10;
  "terminal.integrated.defaultProfile.osx" = "zsh";
  "terminal.integrated.cursorBlinking" = true;
  "terminal.integrated.cursorStyle" = "line";
  "terminal.integrated.enableImages" = true;
  "terminal.integrated.shellIntegration.enabled" = true;

  # Git & GitHub
  "git.autofetch" = true;
  "git.openRepositoryInParentFolders" = "never";
  "github.copilot.editor.enableAutoCompletions" = true;
  "github.copilot.enable" = {
    "*" = true;
    "markdown" = false;
    "plaintext" = false;
  };

  # Files & Workspace
  "files.autoSave" = "afterDelay";
  "files.associations" = {
    "*.env*" = "dotenv";
    # "*.nix" = "nix";
    "*.toml.tmpl" = "toml";
    "*Brewfile*" = "ruby";
    ".envrc" = "shellscript";
    ".aliases" = "shellscript";
    ".bashrc" = "shellscript";
    ".zshrc" = "shellscript";
  };

  # Python Settings
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
      "name" = "inspect_ai";
      "depth" = 2;
    }
  ];
  "python.testing.pytestEnabled" = true;

  # Jupyter
  "jupyter.askForKernelRestart" = false;
  "jupyter.themeMatplotlibPlots" = true;
  "notebook.formatOnSave.enabled" = true;
  "notebook.lineNumbers" = "on";

  # Workbench & UI
  "workbench.activityBar.location" = "top";
  "workbench.iconTheme" = "material-icon-theme";
  "workbench.colorCustomizations" = {
    "editor.lineHighlightBackground" = "#1073cf2d";
    "statusBar.background" = "#005f5f";
    "statusBar.foreground" = "#ffffff";
    "activityBar.background" = "#4B2125";
    "titleBar.activeBackground" = "#692E33";
    "titleBar.activeForeground" = "#FDFBFC";
  };

  # Window
  "window.title" =
    "🪿\${activeRepositoryName} (\${activeRepositoryBranchName}) \${separator} \${activeEditorMedium}";
  "window.commandCenter" = false;

  # Remote SSH
  "remote.SSH.showLoginTerminal" = true;
  "remote.SSH.localServerDownload" = "always";

  # Extensions & Tools
  # Described in
  "ruff.configuration" = "~/.config/ruff/ruff.toml";
  "tinymist.formatterMode" = "typstyle";
  "vim.enableNeovim" = true;
  "vim.smartRelativeLine" = true;
  "errorLens.messageEnabled" = true;
}
