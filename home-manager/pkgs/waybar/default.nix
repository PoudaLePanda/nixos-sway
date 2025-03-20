# home-manager/pkgs/waybar/default.nix
{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./waybar.nix
    ./settings.nix
    ./style.nix
  ];
}
