# hosts/server.nix
#
# Only to be used for headless servers,with more
# security/automation-minded configuration.

{ config, lib, pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_5_15_hardened;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  systemd = {
    services.clear-log = {
      description = "Clear >1 month-old logs every week";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.systemd}/bin/journalctl --vacuum-time=30d";
      };
    };
    timers.clear-log = {
      wantedBy = [ "timers.target" ];
      partOf = [ "clear-log.service" ];
      timerConfig.OnCalendar = "weekly UTC";
    };
  };
}
