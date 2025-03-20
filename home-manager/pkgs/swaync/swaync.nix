# home-manager/pkgs/swaync/default.nix
{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [swaynotificationcenter];
  imports = [
    ./style.nix
  ];
  xdg.configFile."swaync/config.json".source = ./config.json;
}
