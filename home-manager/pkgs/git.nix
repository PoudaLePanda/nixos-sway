{config, pkgs, ...}:
{
    programs.git = {
      enable = true;
      userName  = "PoudaLEPanda";
      userEmail = "leo.meyniel@proton.me";
      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = false;
      };
    };
}