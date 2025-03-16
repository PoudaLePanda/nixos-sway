# ./host/configuration.nix
{ pkgs, inputs,... }:
let
    system = "x86_64-linux";
    backgroundImage = ../background.png;
    avatarImage = ../avatar.png;
in
{
    home-manager.backupFileExtension = "backup";

    imports = [
        ./hardware-configuration.nix
        ./gnome.nix
        ./pkgs/nix.nix
        ./pkgs/proton-vpn.nix
        ./pkgs/amd-drivers.nix
        # ./pkgs/btop/default.nix
        ./pkgs/minecraft.nix
        ./pkgs/steam.nix
    ];

    boot = {
        initrd.kernelModules = [ "amdgpu" ];
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
                splashImage = "${backgroundImage}";
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

    services = {
        dbus.enable = true;
        printing.enable = true;
        displayManager.defaultSession = "gnome";
        xserver = {
          enable = true;
          excludePackages = [ pkgs.xterm ];
          xkb = {
            layout = "us";
            variant = "mac";
          };
          displayManager = {
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
        pulseaudio.enable = false;
        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            wireplumber.enable = true;
        };
    };

    users.users.lmlab = {
        isNormalUser = true;
        description = "lmlab";
        extraGroups = [ "networkmanager" "wheel" ];
    };

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
        jq         # Pour traiter le JSON (utilisé dans tes scripts)
        coreutils  # Fournit cat, awk, etc.
        playerctl
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
        firefox
        inputs.zen-browser.packages."${system}".default
        zathura
    ];

    environment.localBinInPath = true;
    services.devmon.enable = true;
    security.rtkit.enable = true;
    nixpkgs.config.allowUnfree = true;

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

    environment.variables = {
      HOME_MANAGER_CONFIG = "$HOME/DOTFILES/home-manager/home.nix";
    };

    system.stateVersion = "24.11";
}
