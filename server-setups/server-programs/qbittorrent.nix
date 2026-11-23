{ config, pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        libnatpmp
    ];

# services.jackett.enable = true;
    systemd.timers."qbittorrent-port-update" = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
            OnBootSec = "45";
            OnUnitActiveSec = "45";
            Unit = "qbittorrent-port-update.service";
        };
    };

    systemd.services."qbittorrent-port-update" = {
        script = ''
            natpmpc -a 1 0 tcp 60 -g 10.2.0.1
            natpmpc -a 1 0 udp 60 -g 10.2.0.1
            cPort="$(natpmpc -a 1 0 udp 60 -g 10.2.0.1 | grep -zPo '(?<=public port ).*(?= protocol)' | xargs -0)"
            echo "Port detected: $cPort"
            curl -s -b /tmp/.cookies.txt -c /tmp/.cookies.txt "http://localhost:9911/api/v2/app/setPreferences" -d 'json={"listen_port": "'"$cPort"'"}'
            '';
        path = [ pkgs.libnatpmp pkgs.curl ];
        serviceConfig = {
            Type = "oneshot";
            User = "root";
        };
    };

    services.nginx = {
        enable = true;
        virtualHosts = {
            "192.168.1.19" = {
                locations = {
                    "/" = {
                        proxyPass = "http://127.0.0.1:9911";
                        recommendedProxySettings = true;
                    };
                };
            };
        };
    };

    services.qbittorrent = {
        # enable = true;
        openFirewall = true;
        webuiPort = 9911;
        torrentingPort = 39604;
        serverConfig = {
            LegalNotice.Accepted = true;
            Preferences = {
                Downloads.SavePath = "/media/share/Downloads/";
                WebUI = {
                    AuthSubnetWhitelist = "192.168.0.0/24";
                    Username = "jack";
                    ServerDomains = "192.168.1.19";
                    Address = "*";
                };
            };
        };
        user = "qbittorrent";
        group = "qbittorrent";
    };
}
