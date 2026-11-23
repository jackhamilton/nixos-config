{ config, lib, pkgs, pkgs-unstable, ... }:
let
    clientKeys = import ../networking/authorized-client-keys.nix;
    userPasswordHash = config.age.secrets.arr-user-password-hash.path;
in
{
    users.mutableUsers = false;
    users.groups.media = {};
    age.secrets.arr-user-password-hash = {
        file = ../secrets/arr-user-password-hash.age;
        mode = "0400";
    };
    users.users = {
        root = {
            hashedPasswordFile = userPasswordHash;
        };
        prowlarr = {
            isNormalUser = true;
            home = "/home/prowlarr/";
            description = "prowlarr";
            extraGroups = [ "wheel" "media" ];
            openssh.authorizedKeys.keys = clientKeys;
            hashedPasswordFile = userPasswordHash;
        };
        sonarr = {
            isNormalUser = true;
            home = "/home/sonarr/";
            description = "sonarr";
            extraGroups = [ "wheel" "media" ];
            openssh.authorizedKeys.keys = clientKeys;
            hashedPasswordFile = userPasswordHash;
        };
        radarr = {
            isNormalUser = true;
            home = "/home/radarr/";
            description = "radarr";
            extraGroups = [ "wheel" "media" ];
            openssh.authorizedKeys.keys = clientKeys;
            hashedPasswordFile = userPasswordHash;
        };
        lidarr = {
            isNormalUser = true;
            home = "/home/lidarr/";
            description = "lidarr";
            extraGroups = [ "wheel" "media" ];
            openssh.authorizedKeys.keys = clientKeys;
            hashedPasswordFile = userPasswordHash;
        };
        whisparr = {
            isNormalUser = true;
            home = "/home/whisparr/";
            description = "whisparr";
            extraGroups = [ "wheel" "media" ];
            openssh.authorizedKeys.keys = clientKeys;
            hashedPasswordFile = userPasswordHash;
        };
        readarr = {
            isNormalUser = true;
            home = "/home/readarr/";
            description = "readarr";
            extraGroups = [ "wheel" "media" ];
            openssh.authorizedKeys.keys = clientKeys;
            hashedPasswordFile = userPasswordHash;
        };
        bazarr = {
            isNormalUser = true;
            home = "/home/bazarr/";
            description = "bazarr";
            extraGroups = [ "wheel" "media" ];
            openssh.authorizedKeys.keys = clientKeys;
            hashedPasswordFile = userPasswordHash;
        };
        jack = {
            isNormalUser = true;
            home = "/home/jack/";
            description = "Jack";
            extraGroups = [ "wheel" ];
            openssh.authorizedKeys.keys = clientKeys;
            hashedPasswordFile = userPasswordHash;
        };
    };
}
