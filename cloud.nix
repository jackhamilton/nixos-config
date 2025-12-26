{
  config,
  lib,
  pkgs,
  modulesPath,
  media_mountpoint,
  uid,
  gid,
  ...
}:
let
  # i know it says not to do this but my deployed machines are secure (every sysadmin ever)
  media-password = builtins.readFile config.age.secrets.media-password.path;
in
{
  age.secrets.media-password.file = "./secrets/media-password.age";
  fileSystems = {
    "/media/share" = {
      device = "//192.168.1.11/jack/${media_mountpoint}";
      fsType = "cifs";
      options = [
        "username=jack"
        "password=${media-password}"
        "uid=${uid}"
        "gid=${gid}"
        "file_mode=0777"
        "dir_mode=0777"
        "noperm"
        "nounix"
      ];
    };
  };
}
