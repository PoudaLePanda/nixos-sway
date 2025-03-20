{
  inputs,
  config,
  pkgs,lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    brightnessctl
  ];

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.default;
      portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    };
    dconf.enable = true;
  };

  # tty service config
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      # common.default = ["gtk"];
      hyprland.default = ["hyprland"];
    };

    extraPortals = [
      # pkgs.xdg-desktop-portal-gtk
    ];
  };

  services = {
    # Bluetooth manager
    blueman.enable = true;
    # Init session with hyprland
    greetd = {
      enable = true;
      settings = rec {
        regreet_session = {
        command = "${pkgs.cage}/bin/cage -s -- ${pkgs.greetd.regreet}/bin/regreet";
        user = "greeter";
        };
        tuigreet_session =
          let
          session = "${pkgs.hyprland}/bin/Hyprland";
          tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
          in
          {
          command = "${tuigreet} --time --remember --cmd ${session}";
          user = "greeter";
          };
        default_session = tuigreet_session;
      };
    };
    # Allows Hyprland to run without root privileges
    seatd.enable = true;
  };
}
