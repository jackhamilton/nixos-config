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

  environment.systemPackages = [
    pkgs.qmk-udev-rules
  ];

  services.udev.packages = [
    pkgs.qmk-udev-rules
  ];

    hardware.graphics.enable = true;  # Before 24.11: hardware.opengl.driSupport
# For 32 bit applications
    hardware.graphics.enable32Bit = true;  # Before 24.11: hardware.opengl.driSupport32Bit
    hardware.graphics.extraPackages = with pkgs; [
      rocmPackages.clr
    ];

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.brlaser ];

  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
}
