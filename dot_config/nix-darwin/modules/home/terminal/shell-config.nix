{ secrets }:
let
  sharedShellInit = ''
    # TODO: Convert to use LastPass
    export EDITOR=cursor

    ### API KEYS FROM secrets.nix
    # AI API KEYS
    export OPENAI_API_KEY="${secrets.apiKeys.openai}"
    export ANTHROPIC_API_KEY="${secrets.apiKeys.anthropic}"
    export GEMINI_API_KEY="${secrets.apiKeys.gemini}"

    # OTHER API KEYS
    export UV_PUBLISH_TOKEN="${secrets.apiKeys.pypi-token}"
    export HUGGING_FACE_HUB_TOKEN="${secrets.apiKeys.huggingface}"
    # export GITHUB_TOKEN="${secrets.apiKeys.github}"

    ### AWS
    export AWS_DEFAULT_REGION="${secrets.aws.defaultRegion}"
    export AWS_PROFILE="${secrets.aws.profile}"

    ### MIT
    export CSAIL_USERNAME=${secrets.csailUsername}

    ### COOKIECUTTER
    # TODO: Update to use dynamic xdg config
    export COOKIECUTTER_CONFIG="/Users/gat/.config/nix-darwin/assets/gatlen-cookiecutter-config.yaml"

    ### FAST FETCH
    fastfetch
  '';
in {
  bash = {
    enable = true;
    enableCompletion = true;
    initExtra = sharedShellInit;
  };

  zsh = {
    enable = true;
    enableCompletion = true;
    initContent = sharedShellInit;
    prezto = {
      enable = true;
      python.virtualenvAutoSwitch = true;
      utility.safeOps = true;
    };
    syntaxHighlighting.enable = true;
  };

  nushell.enable = true;
}
