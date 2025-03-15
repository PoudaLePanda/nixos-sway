# ./home/pkgs/fastfetch.nix
{ ... }:
{
  programs.fastfetch = {
    enable = true;
    settings = builtins.fromJSON (builtins.readFile ./config.json);
  };
}
