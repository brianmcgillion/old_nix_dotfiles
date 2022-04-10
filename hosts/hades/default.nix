{ pkgs, config, lib, ... }: {
  imports = [ ./hardware-configuration.nix ];

  ## Modules
  modules = {
    desktop = {
      #      browsers = {
      #        default = "google-chrome";
      #        google-chrome.enable = true;
      #      };
      media = { documents.enable = true; };
      term = {
        default = "terminator";
        terminator.enable = true;
      };
      vm = { qemu.enable = true; };
    };
    dev = {
      rust.enable = false;
      python.enable = false;
    };
    editors = {
      default = "emacs";
      emacs.enable = true;
      emacs.doom.enable = true;
    };
    shell = {
      direnv.enable = true;
      git.enable = true;
      gnupg.enable = true;
      tmux.enable = true;
      zsh.enable = true;
    };
    services = {
      ssh.enable = false;
      docker.enable = true;
      # Needed occasionally to help the parental units with PC problems
      # teamviewer.enable = true;
    };
  };

  ## Local config
  programs.ssh.startAgent = true;
  services.openssh.startWhenNeeded = false;

  networking.networkmanager.enable = true;
  networking.hostName = "hades"; # Define your hostname

  # The global useDHCP flag is deprecated, therefore explicitly set to false
  # here. Per-interface useDHCP will be mandatory in the future, so this
  # generated config replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp0s20f3.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "Asia/Dubai";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      ubuntu_font_family
      dejavu_fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      nerdfonts
      symbola
    ];
  };
}
