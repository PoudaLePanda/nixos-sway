{pkgs, ...}: {
  home.packages = with pkgs; [
    spicetify-nix
  ];

  programs.spicetify = let
    spicetify-pkgs = pkgs.spicetify-nix;
  in {
    enable = true;
    enabledExtensions = with spicetify-pkgs.extensions; [
      fullScreen
      betterGenres
      volumePercentage
    ];
    enabledCustomApps = with spicetify-pkgs.apps; [
      lyricsPlus
      historyInSidebar
    ];
    theme = spicetify-pkgs.themes.hazy;
  };
}
