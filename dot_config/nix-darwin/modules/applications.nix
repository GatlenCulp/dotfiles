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
  # chromium = { enable = true; };
  # firefox = import ../firefox.nix { inherit pkgs; };
}


