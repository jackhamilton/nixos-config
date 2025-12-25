{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
let
  astronautSakura = pkgs.sddm-astronaut.override {
    embeddedTheme = "pixel_sakura";
  };
in
{
  environment.systemPackages = [
    astronautSakura
  ];
  boot.loader = {
    efi.canTouchEfiVariables = true;

    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev"; # required for EFI
      useOSProber = true;

      theme = pkgs.catppuccin-grub;
    };
  };

  # Hyprland setup
  services = {
    displayManager = {
      sessionPackages = [ pkgs.hyprland ];
      defaultSession = "hyprland";
      sddm = {
        enable = true;
        wayland.enable = true;
        theme = "sddm-astronaut-theme";
        extraPackages = [ pkgs.sddm-astronaut ];
      };
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
