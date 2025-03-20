{
  config,
  pkgs,
  ...
}: {
  # lightweight wayland terminal emulator
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        shell = "${pkgs.fish}/bin/fish";
        font = "Noto Nerd font:size=14";
        pad = "12x12";
        dpi-aware = "yes";
        selection-target = "both";
      };
      colors = {
        alpha = 0.5;
      };
    };
  };
}
