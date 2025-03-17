{
  description = "LeoDev flake NixOS Configuration with Home Manager & GNOME Tweaks";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    grub2-themes = {
      url = "github:vinceliuice/grub2-themes";
    };

    superfile.url = "github:yorukot/superfile";
    stylix.url = "github:danth/stylix";
  };


  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
  let
      settings = import (./. + "/settings.nix") {inherit pkgs;};
      pkgs = import nixpkgs {system = settings.system;};
  in
  {
    nixosConfigurations = {
          ${settings.hostname} = nixpkgs.lib.nixosSystem {
            modules = [
              ./host/configuration.nix
              inputs.stylix.nixosModules.stylix
              inputs.grub2-themes.nixosModules.default
              # Add Home Manager as a NixOS module
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.${settings.username} = {
                  imports = [
                    ./home-manager/home.nix
                  ];
                };
                # Pass inputs and settings to Home Manager
                home-manager.extraSpecialArgs = {
                  inherit inputs;
                  inherit settings;
                };
              }
            ];
            specialArgs = {
              inherit inputs;
              inherit settings;
            };
          };
        };
  };
}
