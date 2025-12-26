{pkgs, ...}:
{
    networking = {
        hostName = "nginx";
        defaultGateway = {
            address = "192.168.1.1";
            interface = "eth0@if262";
        };
        nameservers = [ "192.168.1.2" ];
        interfaces = {
            "eth0@if705".ipv4.addresses = [{
                address = "192.168.1.15";
                prefixLength = 28;
            }];
        };
        firewall = {
            allowedTCPPorts = [
                80
                443
            ];
            allowedUDPPorts = [
                80
                443
            ];
        };
    };
}
