{pkgs, ...}: {
  home.packages = with pkgs; [
    # nerd-fonts # (recommended)
    # ffmpeg # (for video thumbnails)
    # fuse-7z-ng # (for archive extraction and preview)
    # jq # (for JSON preview)
    # poppler # (for PDF preview)
    # fd # (for file searching)
    # rg # (for file content searching)
    # fzf # (for quick file subtree navigation)
    # zoxide # (for historical directories navigation)
    # ImageMagick # (for SVG, Font, HEIC, and JPEG XL preview)
    # wl-clipboard # / wl-clipboard / xsel (for Linux clipboard support)

    yazi
  ];
}
