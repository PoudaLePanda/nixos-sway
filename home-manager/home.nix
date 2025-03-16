# ./home/home.nix
{ pkgs, ... }:
let
  NordicTheme = pkgs.nordic;
  gtk4ThemeDir = "${NordicTheme}/share/themes/Nordic";
in
{
    home = {
        username = "lmlab";
        homeDirectory = "/home/lmlab";
        activation = {
            createDirectories = ''
                $DRY_RUN_CMD mkdir -p $VERBOSE_ARG \
                $HOME/DEV \
            '';
        };
        file.".config/gtk-3.0/bookmarks".text = ''
            file:///home/lmlab/DEV DEV
            file:///home/lmlab/DOTFILES DOTFILES
          '';
    };

    programs.git = {
        enable = true;
        userName = "PoudaLePanda";
        userEmail = "leo.meyniel@proton.me";
        extraConfig = {
            init.defaultBranch = "main";
        };
    };

    imports = [
      ./pkgs/nerdfetch/default.nix
      ./pkgs/starship/default.nix
      ./pkgs/zed-editor.nix
      ./pkgs/vscodium.nix
      ./pkgs/ghostty.nix
      ./gnome.nix
    ];

    home.packages = with pkgs; [
        nerd-fonts.zed-mono
        nerd-fonts.noto
        nerd-fonts.hack
        nerd-fonts.jetbrains-mono
        nordic
        nordzy-icon-theme
        nordzy-cursor-theme
        (pkgs.graphite-gtk-theme.override {
            themeVariants = ["teal"];
            tweaks = ["float" "colorful" "nord" "rimless"];
        })
    ];

    xdg.enable = true;

    gtk = {
        enable = true;
        font = {
            name = "Noto Nerd Font";
            size = 12;
        };
        iconTheme = {
            name = "Nordzy";
        };
        cursorTheme = {
            name = "Nordzy-cursors";
            size = 24;
        };
        theme = {
            name = "Nordic";
        };
        gtk3.extraConfig = {
          gtk-application-prefer-dark-theme = true;
        };
        gtk4.extraConfig = {
          gtk-application-prefer-dark-theme = true;
        };
    };

    home.pointerCursor = {
        name = "Nordzy-cursors";
        size = 24;
        package = pkgs.nordzy-cursor-theme;
    };

    home.file.".config/gtk-4.0/assets".source = "${gtk4ThemeDir}/gtk-4.0/assets";
    home.file.".config/gtk-4.0/gtk.css".source = "${gtk4ThemeDir}/gtk-4.0/gtk.css";
    home.file.".config/gtk-4.0/gtk-dark.css".source = "${gtk4ThemeDir}/gtk-4.0/gtk-dark.css";
    home.file.".config/gtk-4.0/thumbnail.png".source = "${gtk4ThemeDir}/gtk-4.0/thumbnail.png";

    nixpkgs.config.allowUnfree = true;
    home.stateVersion = "24.11";
}
