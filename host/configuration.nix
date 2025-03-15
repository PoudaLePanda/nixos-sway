# ./host/configuration.nix
{ pkgs, inputs,... }:
let
    system = "x86_64-linux";
    backgroundImage = ../background.png;
    avatarImage = ../avatar.png;
in
{
  imports =
    [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
        ./gnome.nix
        ./pkgs/nix.nix
        ./pkgs/vpn/proton-vpn.nix
        ./pkgs/firewall.nix
        ./pkgs/amd-drivers.nix
        ./pkgs/zed-editor.nix
        ./pkgs/ghostty.nix
        # ./pkgs/btop/default.nix
        ./pkgs/minecraft.nix
        ./pkgs/steam.nix
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
                splashImage = "${backgroundImage}";
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
    console.keyMap = "us";
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
    security.rtkit.enable = true;

    services = {
        dbus.enable = true;
        # Impression
        printing.enable = true;

        xserver = {
          enable = true;
          excludePackages = [ pkgs.xterm ];
          xkb = {
            layout = "us";
            variant = "mac";
          };
          displayManager = {
            defaultSession = "gnome";
            gdm = {
                enable = false;
            };
            lightdm = {
                enable = true;
                background = backgroundImage;
                greeters = {
                  gtk = {
                        theme = {
                            name = "Nordic";
                            package = pkgs.nordic;
                        };
                        iconTheme = {
                            name = "Nordzy";
                            package = pkgs.nordzy-icon-theme;
                        };
                        cursorTheme = {
                            name = "Nordzy-cursors";
                            package = pkgs.nordzy-cursor-theme;
                        };
                    };
                };
            };
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
        glib
        home-manager
        nix
        nil
        nixd
        package-version-server
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
       	ags
       	gcc
        glib
        gnumake
        killall
        mesa
        chromium
        ghostty
        zed-editor
        brave
        inputs.zen-browser.packages."${system}".default
        zathura
    ];

    # PATH configuration
    environment.localBinInPath = true;
    # Enable devmon for device management
    services.devmon.enable = true;

    nixpkgs.config.allowUnfree = true;

    # Set User's avatar
    system.activationScripts = {
      script.text = ''
        mkdir -p /var/lib/AccountsService/{icons,users}
        cp ${avatarImage} /var/lib/AccountsService/icons/lmlab
        touch /var/lib/AccountsService/users/lmlab
        if ! grep -q "^Icon=" /var/lib/AccountsService/users/lmlab; then
            if ! grep -q "^\[User\]" /var/lib/AccountsService/users/lmlab; then
            echo "[User]" >> /var/lib/AccountsService/users/lmlab
            fi
            echo "Icon=/var/lib/AccountsService/icons/lmlab" >> /var/lib/AccountsService/users/lmlab
        fi
      '';
    };

    home-manager.backupFileExtension = "backup";
    system.stateVersion = "24.11";
}
