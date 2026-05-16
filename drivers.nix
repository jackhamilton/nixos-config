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
  # Enable 32-bit support for Vulkan and OpenGL
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  # Vulkan loader + 32-bit support
  hardware.opengl.package = pkgs.mesa;

  # ─── Ensure Vulkan is in path ───
  environment.systemPackages = with pkgs; [
    mesa              # AMD Vulkan driver (radv)
    vulkan-loader     # libvulkan.so
    vulkan-tools      # vulkaninfo
  ];

  services.xserver.videoDrivers = [ "amdgpu" ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    (pkgsi686Linux.glibc)
    (pkgsi686Linux.openssl)
    (pkgsi686Linux.alsa-lib)
    (pkgsi686Linux.freetype)
    (pkgsi686Linux.fontconfig)
    (pkgsi686Linux.libpulseaudio)
  ];
}
