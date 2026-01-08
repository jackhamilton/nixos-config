{
  config,
  lib,
  pkgs,
  modulesPath,
  system,
  agenix,
  ...
}:
{
  services.xserver.xkb = {
    layout = "us";
    variant = "colemak_dh";
  };
}
