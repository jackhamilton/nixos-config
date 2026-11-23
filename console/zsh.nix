{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
}
