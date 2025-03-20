{
  config,
  settings,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    btop
  ];

  home.activation.setupBtopConfig = {
    after = ["linkGeneration"];
    before = [];
    data = ''
      if [ ! -f "$HOME/.config/btop" ]; then
      mkdir -p "$HOME/.config/btop"
      cp ${./gruvbox_dark.theme} "$HOME/.config/btop/themes/gruvbox_dark.theme"
      cp ${./btop.conf} "$HOME/.config/btop/btop.conf"
        # S'assurer que l'utilisateur a les droits complets sur le fichier
        chmod 644 "$HOME/.config/btop/btop.conf"
        chmod 644 "$HOME/.config/btop/themes/gruvbox_dark.theme"
        # S'assurer que vous êtes le propriétaire du fichier
        chown $USER:$(id -gn $USER) "$HOME/.config/btop/btop.conf"
        chown $USER:$(id -gn $USER) "$HOME/.config/themes/gruvbox_dark.theme"
      fi
    '';
  };
}
