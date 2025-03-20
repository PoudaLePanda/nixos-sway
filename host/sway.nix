{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  # Sway on Home Manager
  security.polkit.enable = true;
  programs = {
    sway = {
      enable = true;
      package = pkgs.swayfx;
    };
  };
}
