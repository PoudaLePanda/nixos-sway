# ./home/pkgs/cava/default.nix
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cava
  ];

  # Configuration de Cava via un fichier externe
  xdg.configFile."cava/config".source = ./config;

  # Script de démarrage (optionnel)
  home.file.".local/bin/start-cava" = {
    source = ./start-cava;
    executable = true;
  };
}
