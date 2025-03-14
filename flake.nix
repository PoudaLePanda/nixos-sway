{
  description = "LeoDev flake NixOS Configuration with Home Manager & GNOME Tweaks";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    grub2-themes = {
      url = "github:vinceliuice/grub2-themes";
    };
  };

  outputs = { self, nixpkgs, grub2-themes, zen-browser, home-manager }@ inputs:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          {
            _module.args = { inherit inputs; };
          }
          ./host/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.leodev = import ./home/home.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
          grub2-themes.nixosModules.default
        ];
      };
    };
}
