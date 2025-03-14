# ./host/pkgs/ghostty.nix
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ghostty
  ];

  # Créer le fichier de configuration dans ~/.config/ghostty/config
  environment.etc."ghostty/config".text = ''
    theme = catppuccin-mocha
    font-size = 11
    font-family = Noto Nerd Font
    background-opacity = 0.9
    background-blur = true
    unfocused-split-opacity = 0.96
    window-theme = dark
    macos-option-as-alt = true
    font-feature = -liga,-dlig,-calt
    keybind = ctrl+h=goto_split:left
    keybind = ctrl+l=goto_split:right
  '';
}
