{ lib, inputs, pkgs, config, ... }:
{
    imports = [
        "${inputs.nixpkgs-unstable}/nixos/modules/services/misc/seerr.nix"
    ];

    services.seerr = {
        enable = true;
        package = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.seerr;
        openFirewall = true;
    };

    environment.systemPackages = with pkgs; [
        prowlarr
            radarr
            lidarr
            sonarr
            readarr
    ];

    systemd.services."prowlarr" = {
        enable = true;
        description = "Prowlarr service";
        path = [ pkgs.prowlarr pkgs.sqlite pkgs.curl ];
        wantedBy = [ "multi-user.target" ];
        after = [ "network.target" ];
        serviceConfig = {
            ExecStart = "${pkgs.prowlarr}/bin/Prowlarr -nobrowser -data=/var/lib/prowlarr/";
            Type = "simple";
            User = "prowlarr";
        };
    };

    systemd.services."radarr" = {
        enable = true;
        description = "Radarr service";
        path = [ pkgs.radarr pkgs.sqlite pkgs.curl ];
        wantedBy = [ "multi-user.target" ];
        after = [ "network.target" ];
        serviceConfig = {
            ExecStart = "${pkgs.radarr}/bin/Radarr -nobrowser -data=/var/lib/radarr/";
            Type = "simple";
            User = "radarr";
        };
    };

    systemd.services."sonarr" = {
        enable = true;
        description = "Sonarr service";
        path = [ pkgs.sonarr pkgs.sqlite pkgs.curl pkgs.wget ];
        wantedBy = [ "multi-user.target" ];
        after = [ "network.target" ];
        serviceConfig = {
            ExecStart = "${pkgs.sonarr}/bin/NzbDrone -nobrowser -data=/var/lib/sonarr/";
            Type = "simple";
            User = "sonarr";
        };
    };

    systemd.services."lidarr" = {
        enable = true;
        description = "Lidarr service";
        path = [ pkgs.lidarr pkgs.sqlite pkgs.curl ];
        wantedBy = [ "multi-user.target" ];
        after = [ "network.target" ];
        serviceConfig = {
            ExecStart = "${pkgs.lidarr}/bin/Lidarr -nobrowser -data=/var/lib/lidarr/";
            Type = "simple";
            User = "lidarr";
        };
    };

    systemd.services."readarr" = {
        enable = true;
        description = "Readarr service";
        path = [ pkgs.readarr pkgs.sqlite pkgs.curl ];
        wantedBy = [ "multi-user.target" ];
        after = [ "network.target" ];
        serviceConfig = {
            ExecStart = "${pkgs.readarr}/bin/Readarr -nobrowser -data=/var/lib/readarr/";
            Type = "simple";
            User = "readarr";
        };
    };

    services.nginx = {
        enable = true;
        virtualHosts = {
            "192.168.1.17" = {
                locations = {
                    "/prowlarr/" = {
                        proxyPass = "http://127.0.0.1:9696";
                        recommendedProxySettings = true;
                    };
                };
            };
        };
    };
}
