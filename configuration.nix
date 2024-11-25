# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
  };

  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "intel" ];
      windowManager.i3.enable = true;
      displayManager.lightdm.enable = true;
      xkb.layout = "latam";
    };
    displayManager.defaultSession = "none+i3";
    displayManager.autoLogin.enable = true;
    displayManager.autoLogin.user = "elian";
    pipewire.enable = true;
    pipewire.pulse.enable = true;
  };

  networking = {
    hostName = "NixOS";
    networkmanager.enable = true;
  };

  users.users.elian = {
    isNormalUser = true;
    home = "/home/elian";
    description = "Elian AAV";
    extraGroups = [ "wheel" "video" "audio" "networkmanager" ];
    packages = with pkgs; [
      firefox
      hsetroot
      xdg-user-dirs
    ];
  };
  
  environment.systemPackages = with pkgs; [
    neovim
    wget
    elinks
  ];

  fonts = {
    packages = with pkgs; [
      google-fonts
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Roboto Serif" ];
	sansSerif = [ "Roboto" ];
	monospace = ["Roboto Mono"];
      };
    };
  };
  time.timeZone = "America/Argentina/Buenos_Aires";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "la-latin1";
  };

  system.stateVersion = "24.05"; # Don't Change 

}

