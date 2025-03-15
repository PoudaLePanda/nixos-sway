# ./host/pkgs/zed-editor/default.nix
{ pkgs, ... }:
{
  home.packages = [ pkgs.zed ];
  xdg.configFile."zed/settings.json".source = ./settings.jsonc;
}
