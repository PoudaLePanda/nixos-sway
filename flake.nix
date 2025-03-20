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
        ];
        extraSpecialArgs = {
          inherit inputs;
          inherit settings;
        };
      };
    };
  };
}
