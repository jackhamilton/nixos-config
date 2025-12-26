{pkgs, ...}:
{
    environment.systemPackages = with pkgs; [
        wireguard-tools
    ];

    networking = {
        wg-quick.interfaces = {
            wg0 = {
                address = [ "10.2.0.2/32" ];
                dns = [ "10.2.0.1" ];
                privateKeyFile = "/root/wg/private.key";
                peers = [{
                    publicKey = "WNLAmQkeAvdg9QRFMXq7EuwpEWWkltWwiS/DGIcjHjs=";
                    # This determines which network requests go over the vpn. 192.168.2.0/0 would force 192.168.2.* over it.
                    allowedIPs = [ "0.0.0.0/0" ];
                    endpoint = "87.249.134.138:51820";
                }];
            };
        };
    };
}
