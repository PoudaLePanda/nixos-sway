{pkgs, ...}: {
  home.packages = with pkgs; [
    fastfetch
  ];

  home.activation.setupFastfetchConfig = {
    after = ["linkGeneration"];
    before = [];
    data = ''
      if [ ! -f "$HOME/.config/fastfetch/config.jsonc" ]; then
      mkdir -p "$HOME/.config/fastfetch"
      cp ${./config.jsonc} "$HOME/.config/fastfetch/config.jsonc"
      # S'assurer que l'utilisateur a les droits complets sur le fichier
      chmod 644 "$HOME/.config/fastfetch/config.jsonc"
      fi
    '';
  };
}
