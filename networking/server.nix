{
  config,
  lib,
  pkgs,
  hostname,
  ip_address,
  allowedUDPPorts,
  allowedTCPPorts,
  ...
}:
{
  networking.wireless.enable = lib.mkForce false;

  networking = {
    defaultGateway = {
      address = "192.168.1.1";
      interface = "eth0";
    };
    nameservers = [ "192.168.1.2" ];
  };
  networking = {
    hostName = hostname;
    interfaces = {
      "eth0".ipv4.addresses = [
        {
          address = ip_address;
          prefixLength = 28;
        }
      ];
    };
    firewall = {
      allowedTCPPorts = allowedTCPPorts;
      allowedUDPPorts = allowedUDPPorts;
    };
  };

  # ssh
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "yes";
    };
  };
  users.users."root".openssh.authorizedKeys.keys = import ./authorized-client-keys.nix;
  services.fail2ban.enable = true;
}
