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
  programs.yazi = {
    enable = true;
    settings = {
      manager = {
        ratio = [
          1
          4
          3
        ];
        sort_by = "natural";
        sort_sensitive = true;
        sort_reverse = false;
        sort_dir_first = true;
        linemode = "none";
        show_hidden = true;
        show_symlink = true;
      };

      preview = {
        image_filter = "lanczos3";
        image_quality = 90;
        tab_size = 1;
        max_width = 600;
        max_height = 900;
        cache_dir = "";
        ueberzug_scale = 1;
        ueberzug_offset = [
          0
          0
          0
          0
        ];
      };

      tasks = {
        micro_workers = 5;
        macro_workers = 10;
        bizarre_retry = 5;
      };
    };
  };
}
