{ config, pkgs, ... }:

{
  # ───────────────────────────────────────────────────────────────────────────────
  # Programs & Applications
  # ───────────────────────────────────────────────────────────────────────────────
  programs.firefox.enable = true;
  nixpkgs.config.firefox.enableGnomeExtensions = true;

  # ───────────────────────────────────────────────────────────────────────────────
  # Environment Packages
  # ───────────────────────────────────────────────────────────────────────────────
  environment.systemPackages = with pkgs; [
    qemu 

    obsidian
    vscode.fhs
    ghostty 
    gimp 
    inkscape 
    xournalpp
    vdhcoapp
    shortwave
    celluloid
    handbrake

    adw-gtk3
    morewaita-icon-theme
    gnome-tweaks 
    gnome-extension-manager
    gnomeExtensions.dash-to-dock
    gnomeExtensions.alphabetical-app-grid

    smartmontools
    lm_sensors
    s-tui 
    ntfs3g
    dconf2nix
    pciutils
    gparted
    pavucontrol
    jq
    cava
    powertop
    smartmontools
    woeusb

    distrobox

    # home-manager
    vim
    wget
    curl
    openssl_3
    htop
    ffmpeg
    nmap
    sysstat
    netcat
    p7zip
    stress
    wakeonlan
    coreutils-full
    traceroute
    gh 
    git
    libva-utils
    usbutils
    desktop-file-utils 
    fastfetch 
    hyfetch
  ];

  fonts.packages = with pkgs; [
    corefonts vista-fonts helvetica-neue-lt-std
    noto-fonts
    nerd-fonts.jetbrains-mono
  ]; 
}
