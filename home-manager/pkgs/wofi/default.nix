# home-manager/pkgs/wofi/default.nix
{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.wofi = lib.mkForce {
    enable = true;
    settings = {
      show = "dmenu";
      location = "center";
      width = "40%";
      lines = 10;
      always_parse_args = true;
      show_all = true;
      layer = "overlay";
      insensitive = true;
      prompt = "search";
      print_command = true;

      key_expand = "Tab";
      key_forward = "Right";
      key_backward = "Left";
      columns = 1;
      hide_scroll = false;
      no_actions = true;
      search = "";
      matching = "contains";
      allow_images = true;
      image_size = 32;
      gtk_dark = true;
      dynamic_lines = true;
    };

    style = ''
      window {
        margin: 0px;
        border: 1px solid #928374;
        border-radius: 0px;
        background-color: #282828;
        font-family: monospace;
        font-size: 13px;
      }

      #input {
        margin: 5px;
        border: none;
        border-radius: 0px;
        color: #ebdbb2;
        background-color: #282828;
      }

      #input image {
        color: #ebdbb2;
      }

      #inner-box {
        margin: 5px;
        border: none;
        border-radius: 0px;
        border: none;
        background-color: #282828;
      }

      #outer-box {
        margin: 0px;
        border: 1px solid #928374;
        border-radius: 0px;
        background-color: #282828;
      }

      #scroll {
        margin: 0px;
        border: none;
        border-radius: 0px;
      }

      #text {
        margin: 5px;
        border: none;
        border-radius: 0px;
        color: #ebdbb2;
      }

      #entry:selected {
        background-color: #3c3836;
        font-weight: normal;
        border-radius: 0px;
      }

      #entry:selected * {
        background-color: #3c3836;
        font-weight: normal;
        border-radius: 0px;
      }

      #text:selected {
        background-color: #3c3836;
        font-weight: normal;
      }
    '';
  };
}
