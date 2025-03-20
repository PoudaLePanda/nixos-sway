{
  description = "LeoDev flake NixOS Configuration with Home Manager & GNOME Tweaks";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    grub2-themes = {
      url = "github:vinceliuice/grub2-themes";
    };
    stylix.url = "github:danth/stylix";

    # sway

    # add hyprland
    # ags.url = "git+https://github.com/Aylur/ags?rev=60180a184cfb32b61a1d871c058b31a3b9b0743d";
    hyprland.url = "github:hyprwm/Hyprland";
    hypr-contrib.url = "github:hyprwm/contrib";
    hyprpicker.url = "github:hyprwm/hyprpicker";
    anyrun.url = "github:fufexan/anyrun/launch-prefix";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs = {
        hyprgraphics.follows = "hyprland/hyprgraphics";
        hyprlang.follows = "hyprland/hyprlang";
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };
    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      inputs = {
        hyprgraphics.follows = "hyprland/hyprgraphics";
        hyprlang.follows = "hyprland/hyprlang";
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };
    # hypr-dynamic-cursors = {
    #   url = "github:VirtCode/hypr-dynamic-cursors";
    #   inputs.hyprland.follows = "hyprland";
    # };
    # aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    # aagl.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    settings = import (./. + "/settings.nix") {inherit pkgs;};
    pkgs = import nixpkgs {system = settings.system;};
    system = "x86_64-linux";
  in {
    # NixOS configuration entrypoint.
    # 'nixos-rebuild switch --flake .#hostname
    nixosConfigurations = {
      ${settings.hostname} = nixpkgs.lib.nixosSystem {
        modules = [
          inputs.stylix.nixosModules.stylix
          inputs.grub2-themes.nixosModules.default
          (./. + "/host/configuration.nix")
        ];
        specialArgs = {
          inherit inputs;
          inherit settings;
        };
      };
    };

    # Standalone home-manager configuration entrypoint.
    # 'home-manager switch --flake .#username
    homeConfigurations = {
      ${settings.username} = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          (./. + "/home-manager/home.nix")
          inputs.stylix.homeManagerModules.stylix
        ];
        extraSpecialArgs = {
          inherit inputs;
          inherit settings;
        };
      };
    };
  };
}
