{ config, lib, pkgs, modulesPath, hostname, ... }:
{
   services.clipboard-sync.enable = true;
   networking.hostName = hostname; # Define your hostname.

    services.tailscale = {
        enable = true;
        useRoutingFeatures = "client";
    };

  # pdanet+
  # networking.proxy.default = "http://192.168.49.1:8000";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  #
  # environment.sessionVariables = {
  #   http_proxy="http://192.168.49.1:8000";
  #   https_proxy="http://192.168.49.1:8000";
  #   HTTP_PROXY="http://192.168.49.1:8000";
  #   HTTPS_PROXY="http://192.168.49.1:8000";
  # };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
