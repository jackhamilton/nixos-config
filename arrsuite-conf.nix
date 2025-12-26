{ config, pkgs, modulesPath, ... }:
{
    imports = [
        (modulesPath + "/virtualisation/proxmox-lxc.nix")
            ./filesystem.nix
            ./networking.nix
            # ./wireguard.nix
            ./arrsuite.nix
            ./sudo.nix
    ];

    users.mutableUsers = false;

    users.groups.media = {};
    users.users = {
        root = {
            hashedPassword = "$6$2Z23uSJF5peQi4/0$ZzJqIV5bXUU5ss4QpuGjDc/P7l5ZrukQLx3kP03EYrboRmc5UbX5rI8P5S1SoCFiRxyGOR//osYoUD.KLsftf/";
        };
        prowlarr = {
            isNormalUser = true;
            home = "/home/prowlarr/";
            description = "prowlarr";
            extraGroups = [ "wheel" "media" ];
            openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGmrioi7+kikRVGjf1dmZYPlQhWn18FuUj5Z0E7swwI8 jack@arch" ];
            hashedPassword = "$6$2Z23uSJF5peQi4/0$ZzJqIV5bXUU5ss4QpuGjDc/P7l5ZrukQLx3kP03EYrboRmc5UbX5rI8P5S1SoCFiRxyGOR//osYoUD.KLsftf/";
        };
        sonarr = {
            isNormalUser = true;
            home = "/home/sonarr/";
            description = "sonarr";
            extraGroups = [ "wheel" "media" ];
            openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGmrioi7+kikRVGjf1dmZYPlQhWn18FuUj5Z0E7swwI8 jack@arch" ];
            hashedPassword = "$6$2Z23uSJF5peQi4/0$ZzJqIV5bXUU5ss4QpuGjDc/P7l5ZrukQLx3kP03EYrboRmc5UbX5rI8P5S1SoCFiRxyGOR//osYoUD.KLsftf/";
        };
        radarr = {
            isNormalUser = true;
            home = "/home/radarr/";
            description = "radarr";
            extraGroups = [ "wheel" "media" ];
            openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGmrioi7+kikRVGjf1dmZYPlQhWn18FuUj5Z0E7swwI8 jack@arch" ];
            hashedPassword = "$6$2Z23uSJF5peQi4/0$ZzJqIV5bXUU5ss4QpuGjDc/P7l5ZrukQLx3kP03EYrboRmc5UbX5rI8P5S1SoCFiRxyGOR//osYoUD.KLsftf/";
        };
        lidarr = {
            isNormalUser = true;
            home = "/home/lidarr/";
            description = "lidarr";
            extraGroups = [ "wheel" "media" ];
            openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGmrioi7+kikRVGjf1dmZYPlQhWn18FuUj5Z0E7swwI8 jack@arch" ];
            hashedPassword = "$6$2Z23uSJF5peQi4/0$ZzJqIV5bXUU5ss4QpuGjDc/P7l5ZrukQLx3kP03EYrboRmc5UbX5rI8P5S1SoCFiRxyGOR//osYoUD.KLsftf/";
        };
        whisparr = {
            isNormalUser = true;
            home = "/home/whisparr/";
            description = "whisparr";
            extraGroups = [ "wheel" "media" ];
            openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGmrioi7+kikRVGjf1dmZYPlQhWn18FuUj5Z0E7swwI8 jack@arch" ];
            hashedPassword = "$6$2Z23uSJF5peQi4/0$ZzJqIV5bXUU5ss4QpuGjDc/P7l5ZrukQLx3kP03EYrboRmc5UbX5rI8P5S1SoCFiRxyGOR//osYoUD.KLsftf/";
        };
        readarr = {
            isNormalUser = true;
            home = "/home/readarr/";
            description = "readarr";
            extraGroups = [ "wheel" "media" ];
            openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGmrioi7+kikRVGjf1dmZYPlQhWn18FuUj5Z0E7swwI8 jack@arch" ];
            hashedPassword = "$6$2Z23uSJF5peQi4/0$ZzJqIV5bXUU5ss4QpuGjDc/P7l5ZrukQLx3kP03EYrboRmc5UbX5rI8P5S1SoCFiRxyGOR//osYoUD.KLsftf/";
        };
        bazarr = {
            isNormalUser = true;
            home = "/home/bazarr/";
            description = "bazarr";
            extraGroups = [ "wheel" "media" ];
            openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGmrioi7+kikRVGjf1dmZYPlQhWn18FuUj5Z0E7swwI8 jack@arch" ];
            hashedPassword = "$6$2Z23uSJF5peQi4/0$ZzJqIV5bXUU5ss4QpuGjDc/P7l5ZrukQLx3kP03EYrboRmc5UbX5rI8P5S1SoCFiRxyGOR//osYoUD.KLsftf/";
        };
        jack = {
            isNormalUser = true;
            home = "/home/jack/";
            description = "Jack";
            extraGroups = [ "wheel" ];
            openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGmrioi7+kikRVGjf1dmZYPlQhWn18FuUj5Z0E7swwI8 jack@arch" ];
            hashedPassword = "$6$2Z23uSJF5peQi4/0$ZzJqIV5bXUU5ss4QpuGjDc/P7l5ZrukQLx3kP03EYrboRmc5UbX5rI8P5S1SoCFiRxyGOR//osYoUD.KLsftf/";
        };
    };

    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;

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
            sqlite
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    system.stateVersion = "23.11";
}

