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
{
    age = {
        secrets.media-password = {
            file = /etc/nixos/secrets/media-password.age;
            path = "/etc/cifs-credentials/media-share";
        };
        identityPaths = [
            "/home/jack/.ssh/id_ed25519"
        ];
    };

    fileSystems = {
        "/media/share" = {
            device = "//192.168.1.11/jack/${media_mountpoint}";
            fsType = "cifs";
            options = [
                "credentials=/etc/cifs-credentials/media-share"
                    "uid=${uid}"
                    "gid=${gid}"
                    "file_mode=0777"
                    "dir_mode=0777"
                    "noperm"
                    "nounix"
                    "x-systemd.automount"
            ];
        };
    };
}
