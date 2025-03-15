{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.drivers.amdgpu;
in
{
  options.drivers.amdgpu = {
    enable = mkEnableOption "Enable AMD Drivers";
  };

  config = mkIf cfg.enable {
    boot.initrd.kernelModules = [ "amdgpu" ];
    services.xserver.enable = true;
    services.xserver.videoDrivers = [ "amdgpu" ];

    hardware.opengl = {
      enable = true;
      extraPackages = [ pkgs.amdvlk ];
    };

    nixpkgs.config.rocmSupport = true;

    environment.systemPackages = with pkgs; [ lact ];

    systemd.services.lactd = {
      enable = true;
      description = "Radeon GPU monitor";
      after = [ "syslog.target" "systemd-modules-load.service" ];
      serviceConfig = {
        ExecStart = "${pkgs.lact}/bin/lact daemon";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };
}
