{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.useDHCP = false;
  networking.interfaces.enp1s0.useDHCP = true;

  # packages
  environment.systemPackages = with pkgs; [
     wget 
     vim
     tmux
     xterm
     tree
     docker
   ] ++ (import ./binaries.nix) ;



  # services
   services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
    };
    displayManager = {
        defaultSession = "none+i3";
    };
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu 
        i3status
        i3lock
        i3blocks
     ];
    };
  };

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = "no";
    challengeResponseAuthentication = false;
  };

  # virtualisation
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false;

  # users
  users.mutableUsers = false;

  users.users.matth = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; 
    hashedPassword = "$6$B5ISrw/jHaJPXFAm$SZqgWIyVPaw4EIHd0rNX1r9q3Qb9VUFmiVPGytBDZyTNsebpsuskiK0lk0fG/vb5oAyzgfpRL332qLUhs7p120"; # just matth again for configuration purposes
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICI5k26MHX9PcP71ceVSmQ4/jSVxjCc2ULSP4dAJyvwi matth@Host-001"];
  };

  system.stateVersion = "20.03"; # Did you read the comment?
}

