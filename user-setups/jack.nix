{ config, lib, pkgs, modulesPath, ... }:
{
  users.users.jack = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" ];
    packages = with pkgs; [
      tree
    ];
  };

  security.sudo.wheelNeedsPassword = false;
}
