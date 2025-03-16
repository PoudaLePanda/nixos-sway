{ pkgs, lib, ... }:
{
    environment.systemPackages = with pkgs; [
      protonvpn-gui
    ];

    # Résolution DNS fiable quand le VPN est activé
    networking.networkmanager.dns = lib.mkForce "none";

    # Configurer le pare-feu pour permettre le trafic VPN
    networking.firewall = {
      enable = true;
      allowedUDPPorts = [ 1194 53 51820 ]; # Ports OpenVPN et WireGuard utilisés par ProtonVPN
      allowedTCPPorts = [ 443 80 ];        # Ports HTTPS et HTTP pour la connexion initiale
      checkReversePath = "loose";          # Important pour éviter les problèmes de routage
      extraCommands = ''
        # Permettre aux paquets de passer entre les interfaces
        iptables -A FORWARD -i proton0 -j ACCEPT
        iptables -A FORWARD -o proton0 -j ACCEPT
        iptables -t nat -A POSTROUTING -o proton0 -j MASQUERADE
      '';
    };

    # Activer le transfert IP
    boot.kernel.sysctl = {
      "net.ipv4.ip_forward" = 1;
      "net.ipv6.conf.all.forwarding" = 1;
    };

    services.resolved = {
      enable = true;
      fallbackDns = [ "1.1.1.1" "8.8.8.8" ];
      extraConfig = ''
        DNSStubListener=yes
      '';
    };
}
