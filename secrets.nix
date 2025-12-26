let
  laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMfVyUli9cll2BTHAAB8v2pHb3RvI5ycATRIb2YV8Mm6";
  qbittorrent = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDDeHrFQMkpzhrZIYcibxCWcA02xUjoF8WuWxKlIQsxP";
  seafile = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOfcrjDwTNJ9FdFiuOeDUSSeq01EmS2cswb1T7qB08Fs";
  systems = [ laptop qbittorrent seafile ];
in
{
  "secrets/media-password.age" = {
    publicKeys = systems;
    armor = true;
  };
}
