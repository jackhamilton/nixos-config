{
  description = "NixOS configuration (flake)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-older.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.url = "github:catppuccin/nix";
    agenix.url = "github:ryantm/agenix";
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-older,
      agenix,
      catppuccin,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      coreModules = [
        ./configuration.nix
        ./zsh.nix
        ./theme.nix
        agenix.nixosModules.default
      ];
      desktopAdditionalCore = [
        ./boot.nix
        ./console.nix
        ./services.nix
        ./user-setups/jack.nix
        ./networking/desktop.nix
        ./desktop.nix
        catppuccin.nixosModules.catppuccin
      ];
      serverAdditionalCore = [
        ./networking/server.nix
        ./server.nix
        ./container.nix
      ];
    in
    {
      nixosConfigurations = {
        # change "my-host" to your hostname
        # MARK: Laptop configuration
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            inherit system;
          }; # lets modules access inputs if needed
          modules = [
            ./hardware/laptop.nix
            {
              environment.systemPackages = [ agenix.packages.${system}.default ];
            }
          ] ++ coreModules ++ desktopAdditionalCore;
        };

        # MARK: Seafile server
        seafile = nixpkgs-older.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            hostname = "seafile";
            ip_address = "192.168.1.13";
            allowedTCPPorts = [
              8000
              8082
              8080
              80
              443
            ];
            allowedUDPPorts = [
              8000
              8082
              8080
              80
              443
            ];
            media_mountpoint = "seafile";
            uid = "seafile";
            gid = "seafile";
          };
          modules = [
            ./hardware/seafile.nix
            ./server-programs/seafile-program.nix
            ./cloud.nix
            ./wireguard.nix
          ] ++ coreModules ++ serverAdditionalCore;
        };

        # MARK: Qbittorrent server
        qbittorrent = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            hostname = "qBittorrent";
            ip_address = "192.168.1.19";
            media_mountpoint = "";
            uid = "1000";
            gid = "1000";
            allowedUDPPorts = [
              8080
              80
              443
              9911
            ];
            allowedTCPPorts = [
              8080
              80
              443
              9911
            ];
          };
          modules = [
            ./hardware/qbittorrent.nix
            ./server-programs/qbittorrent.nix
            ./wireguard.nix
            ./cloud.nix
          ] ++ coreModules ++ serverAdditionalCore;
        };

        # MARK: Radicale server
        radicale = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            hostname = "radicale";
            ip_address = "192.168.1.12";
            allowedUDPPorts = [
              8080
              80
              443
              5232
            ];
            allowedTCPPorts = [
              8080
              80
              443
              5232
            ];
          };
          modules = [
            ./hardware/radicale.nix
            ./server-programs/radicale.nix
          ] ++ coreModules ++ serverAdditionalCore;
        };

        # MARK: Template server
        nginx = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            hostname = "nginx";
            ip_address = "192.168.1.15";
            allowedUDPPorts = [
                80
                443
            ];
            allowedTCPPorts = [
                80
                443
            ];
          };
          modules = [
            ./hardware/nginx.nix
            ./server-programs/nginx.nix
          ] ++ coreModules ++ serverAdditionalCore;
        };

        # MARK: Template server
        arrsuite = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            hostname = "servarr";
            ip_address = "192.168.1.17";
            uid = "1000";
            gid = "media";
            media_mountpoint = "";
            allowedUDPPorts = [];
            allowedTCPPorts = [];
          };
          modules = [
            ./hardware/arrsuite.nix
            ./misc/arrsuite-config.nix
            ./user-setups/arr-users.nix
            ./cloud.nix
          ] ++ coreModules ++ serverAdditionalCore;
        };

        # MARK: Template server
        template = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            hostname = "template";
            ip_address = "192.168.1.99";
            allowedUDPPorts = [];
            allowedTCPPorts = [];
          };
          modules = [
            ./hardware/template.nix
          ] ++ coreModules ++ serverAdditionalCore;
        };
      };
    };
}
