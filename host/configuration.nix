# ./host/configuration.nix
{ config, pkgs, inputs,... }:
let
    system = "x86_64-linux";
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # WM manager
       ./sddm/default.nix
      ./pkgs/nix.nix
      # Importer la configuration GNOME
      ./gnome.nix
      ./pkgs/fastfetch/default.nix
      ./pkgs/ghostty.nix
      ./pkgs/starship.nix
      ./pkgs/zed-editor.nix
      ./pkgs/proton-vpn.nix
      # ./pkgs/zathura.nix
      # ./pkgs/btop/default.nix
      # Gaming
      # ./pkgs/minecraft.nix
      # ./pkgs/steam.nix
    ];

    # Boot & EFI
    boot = {
        initrd.kernelModules = [ "amdgpu" ];
        loader = {
            # systemd-boot.enable = true;
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
                customResolution = "1920x1080";  # Optional: Set a custom resolution
                splashImage = ./background.jpg;
            };
        };
    };

    # Réseau & localisation
    networking = {
      hostName = "nixos";
      networkmanager.enable = true;
      firewall.enable = true;
    };

    hardware = {
        cpu.amd.updateMicrocode = true;
        graphics = {
            enable = true;
            extraPackages = [ pkgs.amdvlk ];
        };
    };

    time.timeZone = "Europe/Paris";
    i18n.defaultLocale = "fr_FR.UTF-8";
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
    console.keyMap = "fr";
    security.rtkit.enable = true;

    services = {
        dbus.enable = true;
        # Impression
        printing.enable = true;

        xserver = {
          enable = true;
          excludePackages = [ pkgs.xterm ];
          videoDrivers = [ "amdgpu" ];
          xkb = {
            layout = "fr";
            variant = "";
          };
          displayManager.gdm = {
            enable = false;
          };
        };

        # Son via PipeWire
        pulseaudio.enable = false;
        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            wireplumber.enable = true;
        };
    };

    # Utilisateur
    users.users.lmlab = {
        isNormalUser = true;
        description = "lmlab";
        extraGroups = [ "networkmanager" "wheel" ];
    };

    # Paquets système
    programs.firefox.enable = true;

    # Paquets système
    environment.systemPackages = with pkgs; [
       	wget
       	git
       	cowsay
       	htop
       	curl
       	zip
       	xz
       	github-desktop
       	ags
       	gcc
        chromium
        inputs.zen-browser.packages."${system}".default
        zathura
        btop
    ];

    programs.bash.promptInit = ''fastfetch'';

    nixpkgs.config.allowUnfree = true;

    system.stateVersion = "24.11";
}
