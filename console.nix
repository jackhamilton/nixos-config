{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  # Select internationalisation properties.
  i18n = {
    inputMethod = {
        enable = true;
        type = "fcitx5";
    };
    defaultLocale = "en_US.UTF-8";
  };

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "colemak_dh";
  };

  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
}
