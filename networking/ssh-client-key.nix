{ config, hostname, ... }:
let
  keyFile = {
    nixos-laptop = ../secrets/ssh-client-nixos-laptop.age;
    nixos-desktop = ../secrets/ssh-client-nixos-desktop.age;
  }.${hostname};
in
{
  programs.ssh.extraConfig = ''
    IdentityFile /run/agenix/ssh-client-key
    IdentitiesOnly yes
  '';

  age.secrets.ssh-client-key = {
    file = keyFile;
    owner = "jack";
    group = "users";
    mode = "0400";
  };
}
