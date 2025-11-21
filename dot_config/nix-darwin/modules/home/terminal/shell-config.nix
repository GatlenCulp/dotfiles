{ secrets }:
let
  sharedShellInit = ''
    export EDITOR=cursor
    export CSAIL_USERNAME=${secrets.csailUsername}

    # API Keys from secrets.nix
    export OPENAI_API_KEY="${secrets.apiKeys.openai}"
    export ANTHROPIC_API_KEY="${secrets.apiKeys.anthropic}"
    export UV_PUBLISH_TOKEN="${secrets.apiKeys.pypi-token}"
    # export GITHUB_TOKEN="${secrets.apiKeys.github}"
    export HUGGING_FACE_HUB_TOKEN="${secrets.apiKeys.huggingface}"

    export AWS_DEFAULT_REGION="${secrets.aws.defaultRegion}"
    export AWS_PROFILE="${secrets.aws.profile}"

    export COOKIECUTTER_CONFIG="/Users/gat/.config/nix-darwin/assets/gatlen-cookiecutter-config.yaml"

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
