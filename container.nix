{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  # imports = [
  #   (modulesPath + "/virtualization/proxmox-lxc.nix")
  # ];
  boot.isContainer = true;
}
