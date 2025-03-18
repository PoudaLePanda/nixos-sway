{pkgs, ...}: {
  home.packages = with pkgs; [
    zed-editor
    nil # Le serveur de langage Nix
    alejandra # Le formateur Nix que vous utilisez
  ];

  home.activation.setupZedConfig = {
    after = ["linkGeneration"];
    before = [];
    data = ''
      if [ ! -f "$HOME/.config/zed/settings.json" ]; then
        mkdir -p "$HOME/.config/zed"
        cp ${./settings.json} "$HOME/.config/zed/settings.json"
        # S'assurer que l'utilisateur a les droits complets sur le fichier
        chmod 644 "$HOME/.config/zed/settings.json"
        # S'assurer que vous êtes le propriétaire du fichier
        chown $USER:$(id -gn $USER) "$HOME/.config/zed/settings.json"
      fi
    '';
  };
}
