# ./home/wallpaper/default.nix
{lib, ...}:
{
  options.wallpaper = lib.mkOption {
    type = lib.types.path;
    default = ./wallpaper.png;
    readOnly = true;
    description = "Path to default wallpaper";
  };
}
