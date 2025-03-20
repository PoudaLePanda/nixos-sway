{inputs, ...}: {
  imports = [
    ./hyprland.nix
    ./config.nix
    ./binds.nix
    ./animations.nix
    ./windowrules.nix
    # ./hyprlock.nix
    # ./wlogout.nix
    ./variables.nix
    inputs.hyprland.homeManagerModules.default
  ];
}
