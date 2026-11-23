{ config, pkgs, modulesPath, ... }:
{
    age.secrets.homepage-dashboard-env = {
        file = ../secrets/homepage-dashboard-env.age;
        mode = "0400";
    };

    security.acme = {
        acceptTerms = true;
        defaults.email = "jackham800@gmail.com";
        certs."jackhamilton.uk" = {
            dnsProvider = "cloudflare";
            webroot = null;
            dnsResolver = "1.1.1.1:53";
            environmentFile = "/var/lib/acme/key.crd";
        };
    };
    environment.etc."nginx/modsec/modsecurity.conf".text = ''
        SecRuleEngine On
        SecRequestBodyAccess On
        SecResponseBodyAccess On
        SecAuditLog /var/log/modsec_audit.log
        SecAuditLogParts ABIFHZ

        # Load CRS configuration and rules
        include /etc/modsecurity/crs/crs-setup.conf
        include /etc/modsecurity/crs/rules/*.conf
                                               '';
    services.fail2ban = {
       enable = true;
       jails = {
         nginx-http-auth = ''
           enabled  = true
           port     = http,https
           logpath  = /var/log/nginx/*.log
           backend  = polling
           journalmatch =
         '';
         nginx-botsearch = ''
           enabled  = true
           port     = http,https
           logpath  = /var/log/nginx/*.log
           backend  = polling
           journalmatch =
         '';
         nginx-bad-request = ''
           enabled  = true
           port     = http,https
           logpath  = /var/log/nginx/*.log
           backend  = polling
           journalmatch =
         '';
       };
    };
    services.nginx = {
        enable = true;
        additionalModules = [ pkgs.nginxModules.modsecurity ];

        virtualHosts."jellyfin.jackhamilton.uk" = {
            extraConfig = ''
                modsecurity on;
                modsecurity_rules_file /etc/nginx/modsec/modsecurity.conf;
            '';
            enableACME = true;
            locations = {
                "/" = {
                    proxyPass = "http://192.168.1.30:8096";
                    proxyWebsockets = true;
                };
            };
        };

        virtualHosts."plex.jackhamilton.uk" = {
            extraConfig = ''
                modsecurity on;
                modsecurity_rules_file /etc/nginx/modsec/modsecurity.conf;
            '';

            enableACME = true;
            locations = {
                "/" = {
                    proxyPass = "http://192.168.1.10:32400";
                    proxyWebsockets = true;
                };
            };
        };

        virtualHosts."trilium.jackhamilton.uk" = {
            extraConfig = ''
                modsecurity on;
                modsecurity_rules_file /etc/nginx/modsec/modsecurity.conf;
            '';

            enableACME = true;
            locations = {
                "/" = {
                    proxyPass = "http://192.168.1.24:8080";
                    proxyWebsockets = true;
                };
            };
        };

        virtualHosts."files.jackhamilton.uk" = {
            extraConfig = ''
                modsecurity off;
                modsecurity_rules_file /etc/nginx/modsec/modsecurity.conf;
            '';

            enableACME = true;
            locations = {
              "/" = {
                proxyPass = "http://192.168.1.13:8000";
                proxyWebsockets = true;  # Needed for Seahub
                extraConfig = ''
                  proxy_set_header Host $host;
                  proxy_set_header X-Real-IP $remote_addr;
                  proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                  proxy_set_header X-Forwarded-Proto https;
                  proxy_pass_request_headers on;
                  proxy_request_buffering off;
                '';
              };

              "/seafhttp" = {
                proxyPass = "http://192.168.1.13:8082";
                extraConfig = ''
                  rewrite ^/seafhttp(.*)$ $1 break;
                  proxy_set_header Host $host;
                  proxy_set_header X-Real-IP $remote_addr;
                  proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                  proxy_connect_timeout  36000s;
                  proxy_read_timeout  36000s;
                  proxy_send_timeout  36000s;
                  send_timeout         36000s;
                '';
              };
            };
        };

        virtualHosts."dav.jackhamilton.uk" = {
            extraConfig = ''
                modsecurity off;
                modsecurity_rules_file /etc/nginx/modsec/modsecurity.conf;
            '';

            enableACME = true;
            locations = {
              "/" = {
                proxyPass = "http://192.168.1.12:5232";
                proxyWebsockets = true;
              };
            };
        };

        virtualHosts."jackhamilton.uk" = {
            extraConfig = ''
                modsecurity on;
                modsecurity_rules_file /etc/nginx/modsec/modsecurity.conf;
            '';

            serverAliases = [ "www.jackhamilton.uk" ];
            enableACME = true;
            locations = {
                "/" = {
                    proxyPass = "http://localhost:8082";
                    proxyWebsockets = true;
                };
            };
        };

    };
    services.cloudflared = {
        enable = true;
        tunnels = {
            "d85de4d6-365d-4919-9d72-11fd4bf8cf4b" = {
                credentialsFile = "/var/lib/cloudflared/d85de4d6-365d-4919-9d72-11fd4bf8cf4b.json";
                default = "http_status:404";
                ingress = {
                    "*.jackhamilton.uk" = {
                        service = "http://localhost:80";
                    };
                    "jackhamilton.uk" = {
                        service = "http://localhost:80";
                    };
                };
            };
        };
    };
    services.homepage-dashboard = {
        enable = true;
        environmentFiles = [ config.age.secrets.homepage-dashboard-env.path ];
        bookmarks = [
            {
                Productivity = [
                    {
                        Github = [
                            {
                                abbr = "GH";
                                href = "https://github.com/jackhamiltondev";
                            }
                        ];
                    }
                    {
                        Mail = [
                            {
                                abbr = "PM";
                                href = "https://protonmail.com";
                            }
                        ];
                    }
                ];
            }
            {
                Entertainment = [
                    {
                        YouTube = [
                            {
                                abbr = "YT";
                                href = "https://youtube.com";
                            }
                        ];
                    }
                    {
                        Twitter = [
                            {
                                abbr = "TW";
                                href = "https://x.com";
                            }
                        ];
                    }
                    {
                        Reddit = [
                            {
                                abbr = "RD";
                                href = "https://reddit.com";
                            }
                        ];
                    }
                ];

            }
        ];
        services = [
            {
                "Applications" = [
                    {
                        "Seafile" = {
                            href = "http://files.jackhamilton.uk";
                        };
                    }
                    {
                        "Plex" = {
                            href = "http://plex.jackhamilton.uk";
                            widget = {
                                type = "plex";
                                url = "http://plex.jackhamilton.uk";
                                key = "{{HOMEPAGE_VAR_PLEX_API_KEY}}";
                            };
                        };
                    }
                    {
                        "Jellyfin" = {
                            href = "http://jellyfin.jackhamilton.uk";
                            widget = {
                                type = "jellyfin";
                                url = "http://jellyfin.jackhamilton.uk";
                                key = "{{HOMEPAGE_VAR_JELLYFIN_API_KEY}}";
                            };
                        };
                    }
                    {
                        "Trilium" = {
                            href = "http://trilium.jackhamilton.uk";
                        };
                    }
                ];
            }
            {
                "Intranet" = [
                    {
                        "QBittorrent" = {
                            href = "http://192.168.1.19";
                            widget = {
                                type = "qbittorrent";
                                url = "http://192.168.1.19";
                                username = "jack";
                                password = "{{HOMEPAGE_VAR_QBITTORRENT_PASSWORD}}";
                            };
                        };
                    }
                    {
                        "Radarr" = {
                            href = "http://192.168.1.17:7878";
                            description = "Movie service";
                            widget = {
                                type = "radarr";
                                url = "http://192.168.1.17:7878";
                                key = "{{HOMEPAGE_VAR_RADARR_API_KEY}}";
                            };
                        };
                    }
                    {
                        "Sonarr" = {
                            href = "http://192.168.1.17:8989";
                            description = "TV service";
                            widget = {
                                type = "sonarr";
                                url = "http://192.168.1.17:8989";
                                key = "{{HOMEPAGE_VAR_SONARR_API_KEY}}";
                            };
                        };
                    }
                    {
                        "Prowlarr" = {
                            href = "http://192.168.1.17:9696";
                            description = "Tracker service";
                            widget = {
                                type = "prowlarr";
                                url = "http://192.168.1.17:9696";
                                key = "{{HOMEPAGE_VAR_PROWLARR_API_KEY}}";
                            };
                        };
                    }
                    {
                        "Readarr" = {
                            href = "http://192.168.1.17:8787";
                            description = "Book service";
                        };
                    }
                    {
                        "Lidarr" = {
                            href = "http://192.168.1.17:8686";
                            description = "Music service";
                        };
                    }
                ];
            }
            {
                "Administration" = [
                    {
                        "OpenWRT" = {
                            href = "https://192.168.1.1/cgi-bin/luci/";
                            widget = {
                                type = "openwrt";
                                url = "https://192.168.1.1/cgi-bin/luci/";
                                username = "jack";
                                password = "{{HOMEPAGE_VAR_OPENWRT_PASSWORD}}";
                            };
                        };
                    }
                    {
                        "Proxmox" = {
                            href = "https://192.168.1.8:8006/#v1:0:18:4:::::::";
                            widget = {
                                type = "proxmox";
                                url = "https://192.168.1.8";
                                username = "root";
                                password = "{{HOMEPAGE_VAR_PROXMOX_PASSWORD}}";
                            };
                        };
                    }
                    {
                        "Pihole" = {
                            href = "https://192.168.1.2/admin";
                            widget = {
                                type = "pihole";
                                url = "https://192.168.1.2";
                                version = 6;
                                key = "{{HOMEPAGE_VAR_PIHOLE_API_KEY}}";
                            };
                        };
                    }
                    {
                        "Truenas" = {
                            href = "http://192.168.1.11";
                            widget = {
                                type = "truenas";
                                url = "http://192.168.1.11";
                                key = "{{HOMEPAGE_VAR_TRUENAS_API_KEY}}";
                                nasType = "core";
                            };
                        };
                    }
                    {
                        "Duplicacy" = {
                            href = "192.168.1.23:3875";
                        };
                    }
                    {
                        "Cloudflare" = {
                            href = "https://dash.cloudflare.com/login";
                            widget = {
                                type = "cloudflared";
                                accountid = "3aded00e71934a365a343dbaa1c4ee4d";
                                tunnelid = "d85de4d6-365d-4919-9d72-11fd4bf8cf4b";
                                key = "{{HOMEPAGE_VAR_CLOUDFLARE_WIDGET_KEY}}";
                            };
                        };
                    }
                ];
            }
        ];
        widgets = [
            {
                resources = {
                    cpu = true;
                    memory = true;
                    disk = "/";
                };
            }
            {
                search = {
                    provider = "custom";
                    url = "https://kagi.com/search?q=";
                    focus = true;
                    showSearchSuggestions = true;
                    suggestionUrl = "https://kagi.com/api/autosuggest?q=";
                    target = "_blank";
                };
            }
        ];
        settings = {
            title = "Home";
            description = "Home is where the hypervisor is.";
            theme = "dark";
        };
        # openFirewall = true;
    };
}

