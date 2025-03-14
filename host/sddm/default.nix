# ./host/sddm/default.nix
{ pkgs, lib, ... }:
let
    image = ./pixel_sakura.gif;
  sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "sakura";
    themeConfig = {
      Background = "${toString image}";  # Utilise votre image locale
    };
  };
in {
  services.displayManager = {
    sddm = {
      package = pkgs.kdePackages.sddm;
      extraPackages = [ sddm-astronaut ];
      enable = true;
      wayland.enable = true;
      theme = "sddm-astronaut-theme";
    };
  };

  services.getty = {
    autologinUser = null;
    helpLine = lib.mkForce "";
  };
  systemd.services."getty@tty1".enable = false;

  environment.systemPackages = [ sddm-astronaut ];

  # To prevent getting stuck at shutdown
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";
}
