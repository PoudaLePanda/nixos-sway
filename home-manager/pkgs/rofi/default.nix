{pkgs, ...}: {
  home.packages = with pkgs; [
    rofi
  ];

  home.activation.setupRofiConfig = {
    after = ["linkGeneration"];
    before = [];
    data = ''
      if [ ! -f "$HOME/.config/rofi/theme.rasi" ]; then
      mkdir -p "$HOME/.config/rofi"
      cp ${./theme.rasi} "$HOME/.config/rofi/theme.rasi"
      # S'assurer que l'utilisateur a les droits complets sur le fichier
      chmod 644 "$HOME/.config/rofi/theme.rasi"
      fi
    '';
  };
}
