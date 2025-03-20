{pkgs, ...}: {
  programs.waybar = {
    enable = true;
  };
  # programs.waybar.package = pkgs.waybar.overrideAttrs (oa: {
  #   mesonFlags = (oa.mesonFlags or []) ++ ["-Dexperimental=true"];
  # });

  # Dépendances pour Waybar
  home.packages = with pkgs; [
    pavucontrol # Contrôle du volume audio
    networkmanager_dmenu # interface pour NetworkManager
  ];
}
