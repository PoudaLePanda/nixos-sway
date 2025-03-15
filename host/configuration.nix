# ./host/configuration.nix
{ pkgs, inputs,... }:
let
    system = "x86_64-linux";
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./gnome.nix
      # ./sddm/default.nix
      ./pkgs/nix.nix
      ./pkgs/ghostty.nix
      ./pkgs/proton-vpn.nix
      # ./pkgs/zathura.nix
      # ./pkgs/btop/default.nix
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
                customResolution = "3440x1440";  # Optional: Set a custom resolution
                splashImage = "${./background.jpg}";
            };
        };
        plymouth.enable = true;
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
    console.keyMap = "us";
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
            layout = "us";
            variant = "mac";
          };
          displayManager.gdm = {
            enable = true;
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
        nix
        nil
        nixf
        nixpkgs-fmt
       	wget
       	git
        git-lfs
       	cowsay
       	htop
        btop
       	curl
       	zip
       	xz
       	github-desktop
        home-manager
       	ags
       	gcc
        glib
        gnumake
        killall
        mesa
        chromium
        inputs.zen-browser.packages."${system}".default
        zathura
    ];

    # PATH configuration
    environment.localBinInPath = true;
    # Enable devmon for device management
    services.devmon.enable = true;

    nixpkgs.config.allowUnfree = true;

    # Set User's avatar
    system.activationScripts.script.text = ''
      mkdir -p /var/lib/AccountsService/{icons,users}
      cp ${./avatar.png} /var/lib/AccountsService/icons/lmlab

      touch /var/lib/AccountsService/users/lmlab

      if ! grep -q "^Icon=" /var/lib/AccountsService/users/lmlab; then
        if ! grep -q "^\[User\]" /var/lib/AccountsService/users/lmlab; then
        echo "[User]" >> /var/lib/AccountsService/users/lmlab
        fi
        echo "Icon=/var/lib/AccountsService/icons/lmlab" >> /var/lib/AccountsService/users/lmlab
      fi
    '';

    system.stateVersion = "24.11";
}
