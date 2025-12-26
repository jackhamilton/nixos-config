{ config, lib, pkgs, ... }:

{
    systemd.suppressedSystemUnits = [
        "dev-mqueue.mount"
        "sys-kernel-debug.mount"
        "sys-fs-fuse-connections.mount"
    ];

# start tty0 on serial console
    systemd.services."getty@tty1" = {
        enable = pkgs.lib.mkForce true;
        wantedBy = [ "getty.target" ]; # to start at boot
            serviceConfig.Restart = "always"; # restart when session is closed
    };

    environment.systemPackages = with pkgs; [
        tmux
        neovim
        sqlite
        net-tools
    ];
}
