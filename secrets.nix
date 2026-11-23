let
  laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMfVyUli9cll2BTHAAB8v2pHb3RvI5ycATRIb2YV8Mm6";
  qbittorrent = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDDeHrFQMkpzhrZIYcibxCWcA02xUjoF8WuWxKlIQsxP";
  seafile = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOfcrjDwTNJ9FdFiuOeDUSSeq01EmS2cswb1T7qB08Fs";
  arrsuite = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAIRXh+yp3z2HZrB4nfDEeH02k21EgUo1LlW+5y7EoUZ";
  nginx = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE63bNegHuIbCx2oeF/98fYL3IhfXR7auX2YduYi/ngo";
  desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMdPAEDu+rWyp3Ffq6EdLjU7OUVCGPr/tOvz4E6Bpkpg";
  systems = [ laptop qbittorrent seafile arrsuite desktop ];
in
{
  "secrets/media-password.age" = {
    publicKeys = systems;
    armor = true;
  };
  "secrets/ssh-client-nixos-laptop.age" = {
    publicKeys = [ laptop ];
  };
  "secrets/ssh-client-nixos-desktop.age" = {
    publicKeys = [ desktop ];
  };
  "secrets/homepage-dashboard-env.age" = {
    publicKeys = [ nginx ];
  };
  "secrets/arr-user-password-hash.age" = {
    publicKeys = [ arrsuite ];
  };
  "secrets/seafile-initial-admin-password.age" = {
    publicKeys = [ seafile ];
  };
}
