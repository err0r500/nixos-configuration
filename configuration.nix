{ config, pkgs, ... }:

let
  unstableChannel =
    fetchTarball
      https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
in
{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.useDHCP = false;
  networking.interfaces.enp1s0.useDHCP = true;

  # sound
  sound.enable = true;

  nixpkgs.config = {
    allowUnfree = true; # for slack
  };

  # packages
  environment.systemPackages = with pkgs; [
    xterm
    zsh
    oh-my-zsh
    neovim
    tmux
    ripgrep
    fzf

    tree
    feh
    unzip
    jq
    yq
    htop
    arandr
    ranger
    brave
    vscode

    wget 
    openssl
    dnsutils
    python38Packages.yamllint
    
    go
    ghc
    stack
    cabal-install
    haskellPackages.ghcide
    nodejs-12_x

    docker
    awscli
    kubectl

    chezmoi
    bitwarden-cli

    plantuml
    tla
    tlaplusToolbox

    evince
    slack-dark
  ] ++ (import ./binaries.nix) ;

  programs.vim.defaultEditor = true;
  programs.tmux.extraConfig = "set -g escape-time 0";

  fonts.fonts = with pkgs; [
    fira-code
    source-code-pro
  ];

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
        networkmanagerapplet
     ];
    };
  };

  services.openssh = { #todo: remove this on the laptop
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = "no";
    challengeResponseAuthentication = false;
  };

  # virtualisation
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  virtualisation.libvirtd = { 
    enable = false; # todo: enable this on the laptop
  };

  # users
  users.mutableUsers = false;
  users.defaultUserShell = pkgs.zsh;

  users.users.matth = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; 
    hashedPassword = "$6$2VBLDVwDCb29PGgw$qF9qkunch/uYI2ELmlUzRyUHnYS5KbfOf3pXdvg836aZwbcVlH1omJdhARuK.R3W5KKJlSNujkeDN3vmP06ZU0"; 
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICI5k26MHX9PcP71ceVSmQ4/jSVxjCc2ULSP4dAJyvwi matth@Host-001"];
  };


  system.stateVersion = "20.03";
}

