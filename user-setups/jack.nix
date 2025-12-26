{ config, lib, pkgs, modulesPath, ... }:
{
  users.mutableUsers = false;
  users.users.jack = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" ];
    packages = with pkgs; [
      tree
    ];
  };

  security.sudo.wheelNeedsPassword = false;
}
