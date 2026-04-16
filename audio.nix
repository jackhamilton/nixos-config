{
  config,
  lib,
  pkgs,
  modulesPath,
  system,
  agenix,
  ...
}:
{
    security.rtkit.enable = true;

    environment.systemPackages = [
        pkgs.easyeffects
    ];

    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    services.pipewire.extraConfig.pipewire = {
        context.properties = {
            default.clock-rate = 48000;
            default.allowed-rates = [ 48000 ];
            default.clock.quantum = 1024;
            default.clock.min-quantum = 512;
            default.clock.max-quantum = 8192;
        };
    };

    environment.sessionVariables = {
        PULSE_LATENCY_MSEC = 60;
    };
}
