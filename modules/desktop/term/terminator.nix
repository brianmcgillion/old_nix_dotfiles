# modules/desktop/term/terminator.nix
#
# Enough configurability to work for you
#

{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.term.terminator;
    configDir = config.dotfiles.configDir;
in {
  options.modules.desktop.term.terminator = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    # TODO Fix this as not using xst here
    #modules.shell.zsh.rcInit = ''
    #  [ "$TERM" = xst-256color ] && export TERM=xterm-256color
    #'';
    user.packages = with pkgs; [
      terminator
      (makeDesktopItem {
        name = "terminator";
        desktopName = "Terminator";
        genericName = "Default terminal";
        icon = "utilities-terminal";
        exec = "${terminator}/bin/terminator";
        categories = [ "Development" "System" "Utility" ];
      })
    ];

    home.configFile = {
       "terminator/config".source = "${configDir}/terminator/config";
    };

  };
}
