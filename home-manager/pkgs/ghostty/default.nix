{pkgs, ...}: {
  home.packages = with pkgs; [
    ghostty
  ];

  home.activation.setupGhosttyConfig = {
    after = ["linkGeneration"];
    before = [];
    data = ''
      if [ ! -f "$HOME/.config/ghostty/config" ]; then
        mkdir -p "$HOME/.config/ghostty"
        cp ${./config} "$HOME/.config/ghostty/config"
        # S'assurer que l'utilisateur a les droits complets sur le fichier
        chmod 644 "$HOME/.config/ghostty/config"
        # S'assurer que vous êtes le propriétaire du fichier
        chown $USER:$(id -gn $USER) "$HOME/.config/ghostty/config"
      fi
    '';
  };
}
