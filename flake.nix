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

    superfile.url = "github:yorukot/superfile";
    stylix.url = "github:danth/stylix";
  };


  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    lib = nixpkgs.lib;
    settings = import (./. + "/settings.nix") {inherit pkgs;};
  in
  {
    nixosConfigurations = {
        ${settings.hostname} = lib.nixosSystem rec {
            inherit system;
            specialArgs = { inherit self inputs settings; };
            modules = [
                ./host/configuration.nix
                inputs.stylix.nixosModules.stylix
                inputs.grub2-themes.nixosModules.default
                home-manager.nixosModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.${settings.username} = { config, ... }: {
                      imports = [ ./home-manager/home.nix ];
                      home.homeDirectory = lib.mkForce "/home/${settings.username}";
                    };
                    home-manager.extraSpecialArgs = specialArgs;
                    home-manager.backupFileExtension = "backup";
                }
            ];
        };
    };
  };
}
