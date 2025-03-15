{ pkgs, settings, lib, ... }:
{
    networking.firewall = {
        enable = true;

        # allowedUDPPorts = lib.mkIf settings.enableVPN [51820];
        allowedUDPPorts = [5900 5901 51820];
        allowedTCPPorts = [5900 5901];
    };
}