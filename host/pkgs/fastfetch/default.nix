{ pkgs, ... }:
let
  # Chemin vers votre image personnalisée
  customLogoPath = ./lmlab-logo.png;

  # Création d'un répertoire dans /etc pour le logo
  fastfetchLogoDir = "/etc/fastfetch/logo";
in
{
    environment.systemPackages = with pkgs; [
        fastfetch
    ];

    # Copie de l'image dans /etc/fastfetch/logo/
    system.activationScripts.installFastfetchLogo = ''
      mkdir -p ${fastfetchLogoDir}
      cp ${toString customLogoPath} ${fastfetchLogoDir}/lmlab-logo.png
    '';

    # Configuration de fastfetch avec thème Catppuccin Mocha
    environment.etc."fastfetch/config.jsonc".text = ''
{
"$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
"logo": {
"type": "none"
},
"display": {
"separator": ">  ",
"color": {
"separator": "red"
},
"constants": [
"───────────────────────────────────────────────────────────────────────────",
"│\u001b[75C│\u001b[75D"
]
},
"modules": [
{
"format": "{#1}{#keys}╭{$1}╮\u001b[76D {user-name-colored}{at-symbol-colored}{host-name-colored} 🖥  ",
"type": "title"
},
{
"key": "{$2}{#33}{icon} distro   ",
"type": "os"
},
{
"key": "{$2}{#34}󰇄 desktop  ",
"type": "de"
},
{
"key": "{$2}{#35} term     ",
"type": "terminal"
},
{
"key": "{$2}{#36} shell    ",
"type": "shell"
},
{
"key": "{$2}{#35}󰍛 cpu      ",
"type": "cpu",
"showPeCoreCount": true,
"temp": true
},
{
"key": "{$2}{#34}󰍛 gpu      ",
"type": "gpu"
},
{
"key": "{$2}{#32} memory   ",
"type": "memory"
},
{
"key": "{$2}{#36}󰩟 network  ",
"type": "localip",
"format": "{ipv4} ({ifname})"
},
{
"format": "{#1}{#keys}├{$1}┤",
"type": "custom"
},
{
"key": "{$2}{#39} kernel   ",
"type": "kernel"
},
{
"format": "{#1}{#keys}╰{$1}╯",
"type": "custom"
}
]
}
    '';
}
