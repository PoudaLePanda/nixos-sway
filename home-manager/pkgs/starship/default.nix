# ./home/pkgs/starship.nix
{ ... }:
{
  programs.starship = {
    enable = true;
    palette = "nord";
    settings = builtins.fromTOML (builtins.readFile ./starship.toml);
  };
}
