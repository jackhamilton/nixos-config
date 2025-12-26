{pkgs, ...}:
{
    networking = {
        hostName = "servarr";
        defaultGateway = {
            address = "192.168.1.1";
            interface = "eth0@if262";
        };
        nameservers = [ "192.168.1.2" ];
        # nameservers = [ "1.0.0.1" ];
        interfaces = {
            "eth0@if262".ipv4.addresses = [{
                address = "192.168.1.17";
                prefixLength = 28;
            }];
        };
        firewall.enable = false;
    };
    services.openssh = {
        enable = true;
        settings.PasswordAuthentication = true;
        settings.PermitRootLogin = "yes";
    };
}
