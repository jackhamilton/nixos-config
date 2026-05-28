{
    config,
        lib,
        pkgs,
        modulesPath,
        ...
}:
{
    environment.systemPackages = with pkgs; [
        nixgl.auto.nixGLDefault
        pkgs.qmk-udev-rules
   ];

    programs.steam.enable = true;

    services.flatpak.enable = true;
    services.ratbagd.enable = true;

    services.swapspace.enable = true;

    services.udev.packages = [
        pkgs.qmk-udev-rules
    ];

    hardware.graphics.enable = true;  # Before 24.11: hardware.opengl.driSupport
# For 32 bit applications
        hardware.graphics.enable32Bit = true;  # Before 24.11: hardware.opengl.driSupport32Bit
        hardware.graphics.extraPackages = with pkgs; [
        rocmPackages.clr
        ];

    services.printing.drivers = [ pkgs.brlaser ];


    services.printing = {
        enable = true;
# Allow root AND members of the 'wheel' group to admin printers
        extraConf = ''
            SystemGroup wheel root
            '';
    };

    systemd.services.flatpak-repo = {
        wantedBy = [ "multi-user.target" ];
        path = [ pkgs.flatpak ];
        script = ''
            flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
            '';
    };
}
