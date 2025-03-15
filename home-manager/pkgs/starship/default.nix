# ./home/pkgs/starship/default.nix
{ ... }:
{
  programs.starship = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ./starship.toml);
  };
}
