# ./host/configuration.nix
{
  config,
  inputs,
  lib,
  pkgs,
  settings,
  ...
}: let
  themeDetails = settings.themeDetails;
in {
  imports = [
    ./hardware-configuration.nix

    ./windowManager-common.nix
    ./gnome.nix
    ./sway.nix
    ./hyprland.nix

    ./pkgs/nix.nix
    ./pkgs/proton-vpn.nix
    ./pkgs/amd-drivers.nix
    ./pkgs/minecraft.nix
    ./pkgs/steam.nix
  ];

  boot = {
    initrd.kernelModules = ["amdgpu"];
    loader = {
      timeout = 10;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = false;
      };
      grub2-theme = {
        enable = true;
        theme = "stylish";
        footer = true;
        customResolution = "3440x1440";
        splashImage = "${themeDetails.wallpaper}";
      };
    };
    plymouth.enable = true;
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  hardware = {
    cpu.amd.updateMicrocode = true;
    graphics = {
      enable = true;
      extraPackages = [pkgs.amdvlk];
    };
  };

  time.timeZone = "Europe/Paris";
  console.keyMap = settings.keyMap;
  i18n.defaultLocale = settings.locale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  services = {
    # GTK theme config
    dbus = {
      enable = true;
      packages = [pkgs.dconf];
    };

    # User's credentials manager
    gnome.gnome-keyring.enable = true;
    printing.enable = true;

    # displayManager.defaultSession = "gnome";
    xserver = {
      enable = true;
      excludePackages = with pkgs; [xterm];
      xkb = {
        layout = settings.keyMap;
        variant = settings.variant;
      };
    };

    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };

  users.users.${settings.username} = {
    isNormalUser = true;
    description = settings.username;
    extraGroups = ["networkmanager" "wheel" "video"];
  };

  environment.systemPackages = with pkgs; [
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
    blanket
    htop
    kitty
    cowsay
    git
    git-lfs
    github-desktop
    chromium
    spotify-player
    brave
    firefox
    inputs.zen-browser.packages."${system}".default
    zathura
    vscode
    figlet
    nix-index
    typescript-language-server
    glib
    home-manager
    nix
    package-version-server
    wget
    pciutils
    go-mtpfs
    ntfs3g
    inetutils
    lsof
    curl
    zip
    xz
    dos2unix
    jq # Pour traiter le JSON (utilisé dans tes scripts)
    coreutils # Fournit cat, awk, etc.
    playerctl
    ags
    gcc
    gnumake
    killall
    mesa
    gnome-calendar
    gnome-screenshot
    wayland
    wl-clipboard
  ];

  environment.localBinInPath = true;
  services.devmon.enable = true;
  security.rtkit.enable = true;
  # A lot of mpris packages require it.
  services.gvfs.enable = true;

  system.activationScripts = {
    script.text = ''
      mkdir -p /var/lib/AccountsService/{icons,users}
      cp ${settings.avatarImage} /var/lib/AccountsService/icons/lmlab
      touch /var/lib/AccountsService/users/lmlab
      if ! grep -q "^Icon=" /var/lib/AccountsService/users/lmlab; then
          if ! grep -q "^\[User\]" /var/lib/AccountsService/users/lmlab; then
          echo "[User]" >> /var/lib/AccountsService/users/lmlab
          fi
          echo "Icon=/var/lib/AccountsService/icons/lmlab" >> /var/lib/AccountsService/users/lmlab
      fi
    '';
  };

  system.stateVersion = "24.11";
}
