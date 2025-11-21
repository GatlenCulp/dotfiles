{ pkgs }: {
  # Communication
  thunderbird = {
    enable = true;
    profiles."Gatlen" = { isDefault = true; };
  };
  vesktop.enable = true;

  # Media
  mpv.enable = true;

  # Browsers
  # chromium = { enable = true; }; # Not available on darwin?
  # firefox = import ../firefox.nix { inherit pkgs; };

  # discord = { enable = true; }; # Not yet available

  # ghostty.enable = true # Marked broken?
  # claude-code.enable = true; # Broken?
}


