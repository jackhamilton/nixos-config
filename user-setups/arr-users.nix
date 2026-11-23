{ config, lib, pkgs, pkgs-unstable, ... }:
{
    users.mutableUsers = false;
    users.groups.media = {};
    users.users = {
        root = {
            hashedPassword = "[REDACTED]";
        };
        prowlarr = {
            isNormalUser = true;
            home = "/home/prowlarr/";
            description = "prowlarr";
            extraGroups = [ "wheel" "media" ];
            openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGmrioi7+kikRVGjf1dmZYPlQhWn18FuUj5Z0E7swwI8 jack@arch" ];
            hashedPassword = "[REDACTED]";
        };
        sonarr = {
            isNormalUser = true;
            home = "/home/sonarr/";
            description = "sonarr";
            extraGroups = [ "wheel" "media" ];
            openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGmrioi7+kikRVGjf1dmZYPlQhWn18FuUj5Z0E7swwI8 jack@arch" ];
            hashedPassword = "[REDACTED]";
        };
        radarr = {
            isNormalUser = true;
            home = "/home/radarr/";
            description = "radarr";
            extraGroups = [ "wheel" "media" ];
            openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGmrioi7+kikRVGjf1dmZYPlQhWn18FuUj5Z0E7swwI8 jack@arch" ];
            hashedPassword = "[REDACTED]";
        };
        lidarr = {
            isNormalUser = true;
            home = "/home/lidarr/";
            description = "lidarr";
            extraGroups = [ "wheel" "media" ];
            openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGmrioi7+kikRVGjf1dmZYPlQhWn18FuUj5Z0E7swwI8 jack@arch" ];
            hashedPassword = "[REDACTED]";
        };
        whisparr = {
            isNormalUser = true;
            home = "/home/whisparr/";
            description = "whisparr";
            extraGroups = [ "wheel" "media" ];
            openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGmrioi7+kikRVGjf1dmZYPlQhWn18FuUj5Z0E7swwI8 jack@arch" ];
            hashedPassword = "[REDACTED]";
        };
        readarr = {
            isNormalUser = true;
            home = "/home/readarr/";
            description = "readarr";
            extraGroups = [ "wheel" "media" ];
            openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGmrioi7+kikRVGjf1dmZYPlQhWn18FuUj5Z0E7swwI8 jack@arch" ];
            hashedPassword = "[REDACTED]";
        };
        bazarr = {
            isNormalUser = true;
            home = "/home/bazarr/";
            description = "bazarr";
            extraGroups = [ "wheel" "media" ];
            openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGmrioi7+kikRVGjf1dmZYPlQhWn18FuUj5Z0E7swwI8 jack@arch" ];
            hashedPassword = "[REDACTED]";
        };
        jack = {
            isNormalUser = true;
            home = "/home/jack/";
            description = "Jack";
            extraGroups = [ "wheel" ];
            openssh.authorizedKeys.keys = [
                "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGmrioi7+kikRVGjf1dmZYPlQhWn18FuUj5Z0E7swwI8 jack@arch"
                "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBVtPQ7vtCZEClM2/Tui+gU7BArbN5unegQaAkAhpcT9 jack@laptop-servarr"
            ];
            hashedPassword = "[REDACTED]";
        };
    };
}
