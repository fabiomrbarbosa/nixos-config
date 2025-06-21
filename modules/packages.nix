{ config, pkgs, ... }:

{
  # ───────────────────────────────────────────────────────────────────────────────
  # Display Server & Desktop Environment
  # ───────────────────────────────────────────────────────────────────────────────
  services.xserver = {
    enable = true;
    excludePackages = [ pkgs.xterm ];

    displayManager.gdm.enable = true;
    desktopManager = {
      gnome.enable = true;
      xterm.enable = false;
    };
  };

  # ───────────────────────────────────────────────────────────────────────────────
  # GNOME
  # ───────────────────────────────────────────────────────────────────────────────
  environment.gnome.excludePackages = with pkgs; [
    cheese epiphany totem gnome-tour gnome-music yelp
  ];  

  # ───────────────────────────────────────────────────────────────────────────────
  # Programs & Applications
  # ───────────────────────────────────────────────────────────────────────────────
  programs.firefox.enable = true;
  nixpkgs.config.firefox.enableGnomeExtensions = true;

  # ───────────────────────────────────────────────────────────────────────────────
  # Environment Packages
  # ───────────────────────────────────────────────────────────────────────────────
  environment.systemPackages = with pkgs; [
    # GUI Apps 
    celluloid
    curtail
    ghostty
    gimp
    handbrake
    inkscape
    obsidian
    onlyoffice-bin
    shortwave
    vdhcoapp
    vscode.fhs
    xournalpp

    # Command Line 
    coreutils-full
    curl
    dconf2nix
    desktop-file-utils
    distrobox
    fastfetch
    ffmpeg
    gh
    git
    gparted
    htop
    hyfetch
    inxi
    jq
    libva-utils
    lm_sensors
    netcat
    nmap
    ntfs3g
    openssl_3
    p7zip
    pavucontrol
    pciutils
    powertop
    qemu
    s-tui
    smartmontools
    stress
    sysstat
    traceroute
    usbutils
    vim
    wakeonlan
    wget
    woeusb

    # GNOME
    adw-gtk3
    morewaita-icon-theme
    gnome-tweaks 
    gnome-extension-manager
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock
    gnomeExtensions.alphabetical-app-grid

    # WINE
    wineWowPackages.stable
    winetricks
  ];

  fonts.packages = with pkgs; [
    corefonts 
    vista-fonts 
    helvetica-neue-lt-std
    noto-fonts
    nerd-fonts.jetbrains-mono
    nerd-fonts.caskaydia-cove
    nerd-fonts.caskaydia-mono
  ]; 
}
