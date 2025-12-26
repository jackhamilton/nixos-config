{config, pkgs, ...}:
{
    services.radicale = {
      enable = true;
      settings = {
        server.hosts = [ "0.0.0.0:5232" ];
        auth = {
          type = "htpasswd";
          # htpasswd -c -B /etc/radicale/users jack
          htpasswd_filename = "/etc/radicale/users";
          # hash function used for passwords. May be `plain` if you don't want to hash the passwords
          htpasswd_encryption = "bcrypt";
        };
      };
    };
}
