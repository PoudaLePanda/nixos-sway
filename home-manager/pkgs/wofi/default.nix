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
      show = "drun";
      width = 500;
      height = 400;
      always_parse_args = true;
      show_all = false;
      print_command = true;
      insensitive = true;
      prompt = "";
      key_expand = "Tab";
      key_forward = "Right";
      key_backward = "Left";
      location = "center";
      columns = 1;
      lines = 10;
      hide_scroll = true;
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
        border: 2px solid ${config.lib.stylix.colors.base0C};
        border-radius: 10px;
        background-color: transparent;
        font-family: "Noto Nerd Font";
      }

      #input {
        margin: 5px;
        padding: 10px;
        border: none;
        border-radius: 10px;
        color: ${config.lib.stylix.colors.base05};
        background-color: ${config.lib.stylix.colors.base01};
      }

      #inner-box {
        margin: 5px;
        border: none;
        background-color: ${config.lib.stylix.colors.base00};
        border-radius: 10px;
      }

      #outer-box {
        margin: 5px;
        border: none;
        background-color: ${config.lib.stylix.colors.base00};
        border-radius: 10px;
      }

      #scroll {
        margin: 0px;
        border: none;
      }

      #text {
        margin: 5px;
        border: none;
        color: ${config.lib.stylix.colors.base05};
      }

      #entry {
        padding: 10px;
        border: none;
        border-radius: 10px;
      }

      #entry:selected {
        background-color: ${config.lib.stylix.colors.base0D};
        border-radius: 10px;
      }

      #unselected {
        border-radius: 10px;
      }

      #selected {
        background-color: ${config.lib.stylix.colors.base0D};
        border-radius: 10px;
      }
    '';
  };

  # Création des fichiers de style alternatifs pour plus de personnalisation
  home.file.".config/wofi/style-dark.css".text = ''
    window {
      margin: 0px;
      border: 2px solid ${config.lib.stylix.colors.base0C};
      border-radius: 10px;
      background-color: ${config.lib.stylix.colors.base00};
      font-family: "Noto Nerd Font";
    }

    #input {
      margin: 5px;
      padding: 10px;
      border: none;
      border-radius: 10px;
      color: ${config.lib.stylix.colors.base05};
      background-color: ${config.lib.stylix.colors.base01};
    }

    #inner-box {
      margin: 5px;
      border: none;
      background-color: ${config.lib.stylix.colors.base00};
      border-radius: 10px;
    }

    #outer-box {
      margin: 5px;
      border: none;
      background-color: ${config.lib.stylix.colors.base00};
      border-radius: 10px;
    }

    #scroll {
      margin: 0px;
      border: none;
    }

    #text {
      margin: 5px;
      border: none;
      color: ${config.lib.stylix.colors.base05};
    }

    #entry {
      padding: 10px;
      border: none;
      border-radius: 10px;
    }

    #entry:selected {
      background-color: ${config.lib.stylix.colors.base0D};
      border-radius: 10px;
    }

    #unselected {
      border-radius: 10px;
    }

    #selected {
      background-color: ${config.lib.stylix.colors.base0D};
      border-radius: 10px;
    }
  '';

  home.file.".config/wofi/style-light.css".text = ''
    window {
      margin: 0px;
      border: 2px solid ${config.lib.stylix.colors.base0D};
      border-radius: 10px;
      background-color: ${config.lib.stylix.colors.base00};
      font-family: "Noto Nerd Font";
    }

    #input {
      margin: 5px;
      padding: 10px;
      border: none;
      border-radius: 10px;
      color: ${config.lib.stylix.colors.base05};
      background-color: ${config.lib.stylix.colors.base01};
    }

    #inner-box {
      margin: 5px;
      border: none;
      background-color: ${config.lib.stylix.colors.base00};
      border-radius: 10px;
    }

    #outer-box {
      margin: 5px;
      border: none;
      background-color: ${config.lib.stylix.colors.base00};
      border-radius: 10px;
    }

    #scroll {
      margin: 0px;
      border: none;
    }

    #text {
      margin: 5px;
      border: none;
      color: ${config.lib.stylix.colors.base05};
    }

    #entry {
      padding: 10px;
      border: none;
      border-radius: 10px;
    }

    #entry:selected {
      background-color: ${config.lib.stylix.colors.base0C};
      border-radius: 10px;
    }

    #unselected {
      border-radius: 10px;
    }

    #selected {
      background-color: ${config.lib.stylix.colors.base0C};
      border-radius: 10px;
    }
  '';
}
