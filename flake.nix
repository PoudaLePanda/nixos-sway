{
  description = "LeoDev flake NixOS Configuration with Home Manager & GNOME Tweaks";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Global catppuccin theme
    catppuccin.url = "github:catppuccin/nix";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    grub2-themes = {
      url = "github:vinceliuice/grub2-themes";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, grub2-themes, zen-browser, home-manager, catppuccin }@ inputs:
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
            home-manager.users.lmlab = import ./home/home.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
          grub2-themes.nixosModules.default
        ];
      };
    };
}
