{ ... }:
{
  programs.kdeconnect = {
    enable = true;
    # KDE Connect is installed through the desktop user's Home Manager
    # configuration; this module provides the NixOS integration and firewall.
    package = null;
  };
}
