{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  programs.steam.enable = true;

  services.flatpak.enable = true;
  services.ratbagd.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
}
