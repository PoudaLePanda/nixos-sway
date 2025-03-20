{pkgs, ...}: {
  home.packages = with pkgs; [
    cava
  ];

  home.activation.setupCavaConfig = {
    after = ["linkGeneration"];
    before = [];
    data = ''
      if [ ! -f "$HOME/.config/cava/config" ]; then
      mkdir -p "$HOME/.config/cava"
      cp ${./config} "$HOME/.config/cava/config"
      cp -r ${./shaders} "$HOME/.config/cava/shaders"
      # S'assurer que l'utilisateur a les droits complets sur le fichier
      chmod 644 "$HOME/.config/cava/config"
      chmod -R 644 "$HOME/.config/cava/shaders"
      fi
    '';
  };
}
