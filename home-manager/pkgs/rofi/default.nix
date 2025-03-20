{
  pkgs,
  lib,
  ...
}: {
  programs.rofi = {
    enable = true;
    plugins = with pkgs; [rofi-calc rofi-emoji];
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = lib.mkForce ./theme.rafi;
  };

  # for rofi-emoji to insert emojis directly
  home.packages = [pkgs.xdotool];
}
