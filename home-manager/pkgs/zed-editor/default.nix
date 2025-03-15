# ./host/pkgs/zed-editor.nix
{ pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        zed-editor
    ];

    programs.zed-editor = {
        enable = true;
        settings = (builtins.readFile ./settings.jsonc);
    };
}
