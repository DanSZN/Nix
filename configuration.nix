{ config, pkgs, ... }:
{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true; 

  networking.useDHCP = false;
  networking.interfaces.enp2s0.useDHCP = true;
  
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "en_US.UTF-8/UTF-8" ]; 
    inputMethod.enabled = "fcitx";
  };
 
  time.timeZone = "America/New_York";

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    wget
    vim
    dmenu
    firefox
    git
    kitty
    feh
    scrot
    vivaldi
    rofi
    neovim
    direnv
    adapta-kde-theme
    adapta-gtk-theme
  ];
 
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    hack-font
    symbola
  ];
  
  services.lorri.enable = true;
  
  programs.command-not-found.enable = true;

  services.postgresql.enable = true;
  services.postgresql.package = pkgs.postgresql_11;

  programs.zsh.enable = true;
  programs.zsh.ohMyZsh = {
    enable = true;
    plugins = ["git" "man"];
    theme = "simple";
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;
 
  services.sshd.enable = true;
 
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.windowManager.herbstluftwm.enable = true;
  
  users.users.square = {
    isNormalUser = true;
    extraGroups = [ ];
    shell = pkgs.zsh;
  };
  
  system.stateVersion = "19.09";
}
