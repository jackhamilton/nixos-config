{ config, pkgs, ... }:
{
    environment.systemPackages = with pkgs; [ socat ];

    systemd.services.socat-seahub = {
        description = "Forward TCP 8000 to Seahub's Unix socket";
        after = [ "network.target" "seahub.service" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
            ExecStart = "${pkgs.socat}/bin/socat TCP-LISTEN:8000,fork,reuseaddr UNIX-CONNECT:/run/seahub/gunicorn.sock";
            Restart = "always";
        };
    };

    systemd.services.socat-seafile = {
        description = "Forward TCP 8082 to Seafile's file server Unix socket";
        after = [ "network.target" "seafile.service" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
            ExecStart = "${pkgs.socat}/bin/socat TCP-LISTEN:8082,fork,reuseaddr UNIX-CONNECT:/run/seafile/server.sock";
            Restart = "always";
        };
    };
    services.seafile = {
        enable = true;

        adminEmail = "jackham800@gmail.com";
        initialAdminPassword = "password";

        dataDir = "/media/share";

        ccnetSettings.General.SERVICE_URL = "https://files.jackhamilton.uk";

        seafileSettings = {
            quota.default = "500"; # Amount of GB allotted to users
                history.keep_days = "5"; # Remove deleted files after 14 days

                fileserver = {
                    host = "unix:/run/seafile/server.sock";
                    web_token_expire_time = 18000; # Expire the token in 5h to allow longer uploads
                };

# Enable weekly collection of freed blocks
            gc = {
                enable = true;
            };
        };
        seahubExtraConf = ''
            CSRF_TRUSTED_ORIGINS = ["https://files.jackhamilton.uk"];
        '';
    };
# services.nginx.enable = true;
# services.nginx.virtualHosts."files.jackhamilton.uk" = {
#     locations = {
#         "/" = {
#             proxyPass = "http://unix:/run/seahub/gunicorn.sock";
#             extraConfig = ''
#             proxy_set_header   Host $host;
#             proxy_set_header   X-Real-IP $remote_addr;
#             proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
#             proxy_set_header   X-Forwarded-Host $server_name;
#             proxy_set_header   X-Forwarded-Proto https;
#             proxy_set_header   Cookie $http_cookie;
#             proxy_read_timeout  1200s;
#             client_max_body_size 0;
#             '';
#         };
#         "/seafhttp" = {
#             proxyPass = "http://unix:/run/seafile/server.sock";
#             extraConfig = ''
#                 rewrite ^/seafhttp(.*)$ $1 break;
#             client_max_body_size 0;
#             proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
#             proxy_connect_timeout  36000s;
#             proxy_read_timeout  36000s;
#             proxy_send_timeout  36000s;
#             send_timeout  36000s;
#             '';
#         };
#     };
# };
}
